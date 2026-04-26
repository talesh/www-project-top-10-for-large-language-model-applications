#!/bin/bash
# validate-translation-markdown.sh — pre-flight validator for OWASP translation
# markdown files. Catches the bug classes that have historically broken the v2
# PDF pipeline: BOMs, off-by-one heading levels, 4-space-indented prose
# (triggers Puppeteer page-scaling), CSS hierarchy violations, missing files,
# plus general markdown hygiene via markdownlint-cli2.
#
# Usage:
#   ./validate-translation-markdown.sh [--fix] xx-XX                   # one language
#   ./validate-translation-markdown.sh [--fix]                         # every language under 2_0_vulns/translations/
#   ./validate-translation-markdown.sh --github-annotations xx-XX      # CI mode

set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# REPO_ROOT comes from the *current working directory*, not SCRIPT_DIR. This
# lets the script live in `mine/` (canonical home) while still validating a
# language sitting in a separate per-language worktree (the local layout used
# by automations/) — caller just cd's into the worktree first. In CI the cwd
# is $GITHUB_WORKSPACE (mine checkout root) so this resolves there.
REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
if [ -z "$REPO_ROOT" ] || [ ! -d "$REPO_ROOT/2_0_vulns/translations" ]; then
    echo "Error: cwd is not inside an OWASP repo with 2_0_vulns/translations/." >&2
    echo "  cwd=$PWD" >&2
    echo "  Either cd into the repo root (or a per-language worktree) first." >&2
    exit 2
fi
TRANSLATIONS_DIR="$REPO_ROOT/2_0_vulns/translations"
HEADERS_PY="$SCRIPT_DIR/headers.py"
MARKDOWNLINT_CONFIG="$SCRIPT_DIR/.markdownlint.json"

# ANSI colors (only when stdout is a terminal). Deferred: GH_ANNOT also
# disables colors, but it isn't parsed until later — re-evaluated below.
if [ -t 1 ]; then
    C_RED=$'\033[31m'; C_YEL=$'\033[33m'; C_GRN=$'\033[32m'; C_DIM=$'\033[2m'; C_OFF=$'\033[0m'
else
    C_RED=""; C_YEL=""; C_GRN=""; C_DIM=""; C_OFF=""
fi

ALL_RULES="MISSING-FILE BOM CHAPTER-TITLE-LEVEL INDENTED-PROSE STYLES-CSS-HIERARCHY LEADING-WS-HEADING NO-TRAILING-NEWLINE HEADING-DEEPER-THAN-H4 LONG-HEADING MARKDOWNLINT"

print_usage() {
    cat <<EOF
Usage:
  $0 [--fix] [--rule NAME] <language_code>   validate one translation
  $0 [--fix] [--rule NAME]                   validate every translation in 2_0_vulns/translations/
  $0 --list-rules                            print all rule names and exit

Options:
  --fix          auto-fix safe issues (BOM, off-by-one heading levels, 4-space
                 indents, leading whitespace on headings, missing trailing
                 newlines) plus markdownlint-fixable rules; then re-validate
                 and report what remains.
  --rule NAME    only run/fix this rule (skip all others). Useful when you want
                 to make atomic per-rule commits — fix one rule, commit, repeat.
                 Use --list-rules to see valid names. NAME 'MARKDOWNLINT' covers
                 every MD### finding from markdownlint-cli2.
  --github-annotations
                 Also emit GitHub Actions workflow commands (::error, ::warning)
                 alongside the human-readable output, so findings appear inline
                 in the GitHub UI. Implies non-TTY (no ANSI colors).

Examples:
  $0 vi-VN                              # report everything
  $0 --fix --rule BOM vi-VN             # strip BOMs only, then re-validate
  $0 --fix --rule INDENTED-PROSE vi-VN  # unindent prose only

Exit codes:
  0  no errors (warnings ok)
  1  errors found
  2  bad usage / missing dependencies
EOF
    exit 2
}

# --- argument parsing ------------------------------------------------------

FIX=0
LANG_ARG=""
ONLY_RULE=""
GH_ANNOT=0
while [ $# -gt 0 ]; do
    case "$1" in
        --fix) FIX=1; shift ;;
        --github-annotations) GH_ANNOT=1; shift ;;
        --rule)
            [ $# -lt 2 ] && { echo "Error: --rule requires an argument" >&2; print_usage; }
            ONLY_RULE="$2"
            # Validate against the known rule list so typos fail loudly
            case " $ALL_RULES " in
                *" $ONLY_RULE "*) ;;
                *) echo "Error: unknown rule '$ONLY_RULE'. Run --list-rules to see valid names." >&2; exit 2 ;;
            esac
            shift 2
            ;;
        --list-rules)
            echo "Known rule names (use with --rule):"
            for r in $ALL_RULES; do echo "  $r"; done
            exit 0
            ;;
        -h|--help) print_usage ;;
        --) shift; break ;;
        -*) echo "Error: unknown flag '$1'" >&2; print_usage ;;
        *)  LANG_ARG="$1"; shift ;;
    esac
done
[ $# -gt 0 ] && print_usage

# CI mode: drop ANSI so the GitHub log is clean.
if [ "$GH_ANNOT" -eq 1 ]; then
    C_RED=""; C_YEL=""; C_GRN=""; C_DIM=""; C_OFF=""
fi

# Helper used by every check_*: skip if --rule was passed and doesn't match.
should_run() {
    [ -z "$ONLY_RULE" ] || [ "$ONLY_RULE" = "$1" ]
}

# --- dependency checks -----------------------------------------------------

require_cmd() {
    command -v "$1" >/dev/null 2>&1 || {
        echo "Error: '$1' not found in PATH." >&2
        [ -n "${2:-}" ] && echo "  $2" >&2
        exit 2
    }
}
require_cmd python3
require_cmd markdownlint-cli2 "Install with: npm install -g markdownlint-cli2@0.13.0"
[ -f "$HEADERS_PY" ] || { echo "Error: headers.py not found at $HEADERS_PY" >&2; exit 2; }
[ -f "$MARKDOWNLINT_CONFIG" ] || { echo "Error: $MARKDOWNLINT_CONFIG missing" >&2; exit 2; }

python3 -c "import tinycss2" 2>/dev/null || {
    echo "Error: missing Python 'tinycss2'. Install with:" >&2
    echo "  pip3 install -r '$REPO_ROOT/mine/.github/scripts/pdf-generation/requirements.txt'" >&2
    exit 2
}

# --- language list ---------------------------------------------------------

LANG_CODES=()
if [ -n "$LANG_ARG" ]; then
    if ! echo "$LANG_ARG" | grep -qE '^[a-z]{2}-[A-Z]{2}$'; then
        echo "Error: language code must be xx-XX (e.g. vi-VN)" >&2
        exit 2
    fi
    LANG_CODES=("$LANG_ARG")
else
    [ -d "$TRANSLATIONS_DIR" ] || { echo "Error: $TRANSLATIONS_DIR missing" >&2; exit 2; }
    for entry in "$TRANSLATIONS_DIR"/*/; do
        lang=$(basename "$entry")
        echo "$lang" | grep -qE '^[a-z]{2}-[A-Z]{2}$' || continue
        LANG_CODES+=("$lang")
    done
    [ ${#LANG_CODES[@]} -eq 0 ] && { echo "No translations found in $TRANSLATIONS_DIR."; exit 0; }
fi

# --- per-language validation -----------------------------------------------

# Required ADD files + styles.css. LLM00–LLM10 enforced separately because
# we want the more useful "expected LLMxx_*.md" message instead of an exact
# filename match (filenames vary in the title slug after the underscore).
REQUIRED_NON_LLM=(
    "ADD00_Cover.md"
    "ADD01_Table_of_Contents.md"
    "ADD02_Figures.md"
    "ADD04_Supplemental_Content.md"
    "styles.css"
)

# Counters across all languages (final exit code based on these)
TOTAL_ERR=0
TOTAL_WARN=0
TOTAL_FIXED=0

# Per-language counters reset in run_language()
LANG_ERR=0
LANG_WARN=0
LANG_FIXED=0
LANG_CURRENT=""

emit() {  # emit <SEVERITY> <RULE> <FILE:LINE> <MSG>  [+ extra lines after]
    local sev="$1" rule="$2" loc="$3" msg="$4"; shift 4
    local color
    case "$sev" in
        ERROR)   color="$C_RED"; LANG_ERR=$((LANG_ERR+1)) ;;
        WARNING) color="$C_YEL"; LANG_WARN=$((LANG_WARN+1)) ;;
        FIXED)   color="$C_GRN"; LANG_FIXED=$((LANG_FIXED+1)) ;;
    esac
    printf "  %s%s%s %s [%s]\n    %s\n" "$color" "$sev" "$C_OFF" "$loc" "$rule" "$msg"
    for extra in "$@"; do printf "    %s\n" "$extra"; done

    # GitHub Actions workflow commands. Errors and warnings only — FIXED is
    # noise (the auto-fix already happened). Encodes file path relative to
    # repo root so annotations land on the right file in the PR diff view.
    if [ "$GH_ANNOT" -eq 1 ] && [ "$sev" != "FIXED" ]; then
        local gh_sev="error"
        [ "$sev" = "WARNING" ] && gh_sev="warning"
        # loc may be "file.md", "file.md:42", or "file.md:42:5" (markdownlint).
        # Take everything before the first colon as the path and the next
        # numeric chunk as the line; GitHub doesn't accept "42:5" in line=.
        local file_part="${loc%%:*}" line_part=""
        case "$loc" in
            *:*) line_part="${loc#*:}"; line_part="${line_part%%:*}" ;;
        esac
        # GitHub annotations want a single line — collapse extras with %0A (their newline encoding).
        local full_msg="$msg"
        for extra in "$@"; do full_msg="$full_msg%0A$extra"; done
        # Path the annotation step expects is repo-root-relative.
        local rel_path="2_0_vulns/translations/$LANG_CURRENT/$file_part"
        if [ -n "$line_part" ]; then
            echo "::${gh_sev} file=${rel_path},line=${line_part},title=${rule}::${full_msg}"
        else
            echo "::${gh_sev} file=${rel_path},title=${rule}::${full_msg}"
        fi
    fi
}

# --- individual rules (each is a function: check_<RULE> <src_dir>) ---------

check_missing_files() {
    should_run MISSING-FILE || return 0
    local src="$1"
    for f in "${REQUIRED_NON_LLM[@]}"; do
        if [ ! -f "$src/$f" ]; then
            emit ERROR MISSING-FILE "$f" \
                "Required file not found in translation directory." \
                "Copy the template from automations/metadata-templates/ and fill it in."
        fi
    done
    # LLM00–LLM10 — collect actual filenames so we know which numbers exist
    local found_nums=""
    for f in "$src"/LLM[0-9][0-9]_*.md; do
        [ -f "$f" ] || continue
        local base num
        base=$(basename "$f")
        num=${base:3:2}
        found_nums="$found_nums $num"
    done
    for n in 00 01 02 03 04 05 06 07 08 09 10; do
        if ! echo "$found_nums" | grep -qw "$n"; then
            emit ERROR MISSING-FILE "LLM${n}_*.md" \
                "No file matching LLM${n}_*.md found." \
                "Each chapter must exist as a separate file."
        fi
    done
}

check_bom() {  # also fixes when FIX=1
    should_run BOM || return 0
    local src="$1" f bom
    bom=$(printf '\xef\xbb\xbf')
    for f in "$src"/*.md; do
        [ -f "$f" ] || continue
        local first3
        first3=$(head -c 3 "$f")
        if [ "$first3" = "$bom" ]; then
            local rel="${f#$src/}"
            if [ "$FIX" -eq 1 ]; then
                # Strip the 3-byte BOM in place
                python3 -c "
import sys
p = sys.argv[1]
with open(p, 'rb') as h: data = h.read()
if data.startswith(b'\xef\xbb\xbf'):
    with open(p, 'wb') as h: h.write(data[3:])
" "$f"
                emit FIXED BOM "$rel:1" "Stripped UTF-8 byte-order mark."
            else
                emit ERROR BOM "$rel:1" \
                    "File starts with UTF-8 BOM (invisible 0xEF 0xBB 0xBF). headers.py" \
                    "won't count BOM-prefixed chapter titles. Fix: re-run with --fix" \
                    "or manually strip the first 3 bytes."
            fi
        fi
    done
}

check_chapter_title_level() {  # also fixes when FIX=1 (whole-file demote by 1)
    should_run CHAPTER-TITLE-LEVEL || return 0
    local src="$1" f
    for f in "$src"/LLM[0-9][0-9]_*.md; do
        [ -f "$f" ] || continue
        local rel="${f#$src/}"
        # First non-blank, non-BOM-prefixed line. (BOM detection is its own
        # rule — we look at the line after stripping a possible BOM here so
        # the two checks stack cleanly when both apply.)
        local first
        first=$(python3 -c "
import sys
with open(sys.argv[1], 'rb') as h: data = h.read()
if data.startswith(b'\xef\xbb\xbf'): data = data[3:]
for line in data.decode('utf-8', errors='replace').splitlines():
    if line.strip(): print(line); break
" "$f")
        # We require '## ' (with optional leading whitespace, since headers.py
        # strips before matching). A bare '# ' is the bug we're catching.
        local trimmed="${first#"${first%%[![:space:]]*}"}"  # left-trim
        case "$trimmed" in
            "## "*) ;;  # ok
            "# "*)
                if [ "$FIX" -eq 1 ]; then
                    python3 -c "
import re, sys
p = sys.argv[1]
with open(p) as h: lines = h.readlines()
out = []
for line in lines:
    m = re.match(r'^(#{1,5}) (.*)$', line)
    if m:
        out.append('#' + m.group(1) + ' ' + m.group(2) + ('\n' if line.endswith('\n') else ''))
    else:
        out.append(line)
with open(p, 'w') as h: h.writelines(out)
" "$f"
                    emit FIXED CHAPTER-TITLE-LEVEL "$rel:1" \
                        "Demoted every heading by one level (\`#\` → \`##\`, \`##\` → \`###\`, etc.)."
                else
                    emit ERROR CHAPTER-TITLE-LEVEL "$rel:1" \
                        "Chapter title is \`# …\` (h1), must be \`## …\` (h2)." \
                        "Every heading in this file is off by one. Fix: re-run with --fix" \
                        "or demote every heading in this file by one level."
                fi
                ;;
            *)
                emit ERROR CHAPTER-TITLE-LEVEL "$rel:1" \
                    "First non-blank line is not a \`## \` heading." \
                    "Each LLMxx_*.md must start with the chapter title as \`## LLMxx:…\`."
                ;;
        esac
    done
}

check_indented_prose() {
    should_run INDENTED-PROSE || return 0
    local src="$1" f
    for f in "$src"/*.md; do
        [ -f "$f" ] || continue
        local rel="${f#$src/}"
        # Detect 4-space-indented lines that are NOT properly bracketed by
        # blank lines. Without a blank line above and below, CommonMark treats
        # the line as paragraph continuation (rendering inline as garbage)
        # rather than a <pre><code> block. The auto-fix inserts the missing
        # blank lines so the line parses as a code block — which the
        # styles.css `pre` rule then styles into a visually distinct sample
        # block. This matches the convention the OWASP English source uses
        # for system-prompt examples in LLM07/LLM08.
        #
        # Lines already surrounded by blank lines (Pattern A) render correctly
        # and aren't flagged.
        local result
        result=$(python3 - "$f" "$FIX" <<'PY'
import re, sys, json
path, fix_flag = sys.argv[1], sys.argv[2] == '1'
# 4 spaces followed by a non-whitespace, non-list-marker character. Excluding
# whitespace prevents matching trailing-whitespace-only lines like '    \n'.
# Excluding list markers prevents matching ordered/unordered list content
# that legitimately starts with 4-space indentation inside a list context.
INDENT = re.compile(r'^    [^\s\-\*\+0-9]')

with open(path) as h: lines = h.readlines()
n = len(lines)
def is_blank(i):
    return i < 0 or i >= n or lines[i].strip() == ''

# Find every indented line and classify Pattern A (blanks around) vs B (not).
pattern_b = []  # 0-based line numbers
for i, line in enumerate(lines):
    if INDENT.match(line):
        if not (is_blank(i - 1) and is_blank(i + 1)):
            pattern_b.append(i)

if not pattern_b:
    print(json.dumps({'pattern_b_count': 0}))
    sys.exit(0)

if fix_flag:
    # Walk in reverse so insertion offsets don't shift later indices.
    out = list(lines)
    for i in reversed(pattern_b):
        # Add blank below (if needed) BEFORE blank above so indices stay sane.
        if not is_blank(i + 1):
            out.insert(i + 1, '\n')
        if not is_blank(i - 1):
            out.insert(i, '\n')
    with open(path, 'w') as h: h.writelines(out)

# Build a snippet for the report (first offender, char-truncated for UTF-8 safety).
first_idx = pattern_b[0]
snippet = lines[first_idx].lstrip()[:60]
print(json.dumps({
    'pattern_b_count': len(pattern_b),
    'first_line': first_idx + 1,
    'snippet': snippet,
}))
PY
)
        local count
        count=$(echo "$result" | python3 -c "import json,sys; print(json.loads(sys.stdin.read())['pattern_b_count'])")
        [ "$count" -eq 0 ] && continue
        if [ "$FIX" -eq 1 ]; then
            emit FIXED INDENTED-PROSE "$rel" \
                "Inserted blank lines around $count indented sample line(s) so they parse as <pre>" \
                "blocks instead of flowing inline within paragraphs." \
                "(Pattern B: indented lines wedged between prose with no blank lines around.)"
        else
            local first_line snippet
            first_line=$(echo "$result" | python3 -c "import json,sys; print(json.loads(sys.stdin.read())['first_line'])")
            snippet=$(echo "$result" | python3 -c "import json,sys; print(json.loads(sys.stdin.read())['snippet'])")
            emit WARNING INDENTED-PROSE "$rel:$first_line" \
                "Found $count indented sample line(s) without blank lines around them." \
                "These will render INLINE within the surrounding paragraph (the leading 4" \
                "spaces collapse and the \`>\` becomes literal text), not as the visually-" \
                "distinct <pre> block the author probably intended." \
                "Fix: re-run with --fix to insert blank lines around each indented sample." \
                "First offender: ${snippet}..."
        fi
    done
}

check_styles_css_hierarchy() {
    should_run STYLES-CSS-HIERARCHY || return 0
    local src="$1"
    [ -f "$src/styles.css" ] || return 0  # missing-file rule already reported
    local out
    out=$(python3 -c "
import sys
sys.path.insert(0, '$REPO_ROOT/mine/.github/scripts/pdf-generation')
import importlib.util
spec = importlib.util.spec_from_file_location('h', '$HEADERS_PY')
# headers.py executes on import — read its source and exec only the function we want.
src = open('$HEADERS_PY').read()
ns = {}
exec(compile(src.split('# --- Main logic ---')[0], '$HEADERS_PY', 'exec'), ns)
try:
    sizes = ns['parse_header_sizes_pt']('$src/styles.css')
    print(f\"OK h2={sizes['h2']:.1f} h3={sizes['h3']:.1f} h4={sizes['h4']:.1f}\")
except SystemExit as e:
    print(f'FAIL {e}')
" 2>&1)
    if ! echo "$out" | grep -q "^OK "; then
        emit ERROR STYLES-CSS-HIERARCHY "styles.css" \
            "headers.py rejects this stylesheet. Detail:" \
            "$out" \
            "Required: h2/h3/h4 must each define font-size in px or pt, with h2 > h3 > h4."
    fi
}

check_leading_ws_heading() {
    should_run LEADING-WS-HEADING || return 0
    local src="$1" f
    for f in "$src"/*.md; do
        [ -f "$f" ] || continue
        local rel="${f#$src/}"
        # Match lines beginning with 1-3 spaces followed by '#' (markdown allows
        # this — but it's inconsistent with all other files and was a bug we hit
        # on vi-VN LLM10).
        local hits
        hits=$(awk '/^[ ]{1,3}#/ { print NR }' "$f")
        [ -z "$hits" ] && continue
        if [ "$FIX" -eq 1 ]; then
            python3 -c "
import re, sys
p = sys.argv[1]
with open(p) as h: lines = h.readlines()
changed = 0
out = []
for line in lines:
    if re.match(r'^[ ]{1,3}#', line):
        out.append(line.lstrip(' ')); changed += 1
    else:
        out.append(line)
if changed:
    with open(p, 'w') as h: h.writelines(out)
" "$f"
            local n
            n=$(echo "$hits" | wc -l | tr -d ' ')
            emit FIXED LEADING-WS-HEADING "$rel" "Trimmed leading whitespace from $n heading line(s)."
        else
            local first_line
            first_line=$(echo "$hits" | head -1)
            emit WARNING LEADING-WS-HEADING "$rel:$first_line" \
                "Heading line(s) start with whitespace. Renders fine but is inconsistent." \
                "Fix: re-run with --fix or remove the leading space(s)."
        fi
    done
}

check_long_heading() {
    should_run LONG-HEADING || return 0
    local src="$1" f
    for f in "$src"/LLM[0-9][0-9]_*.md; do
        [ -f "$f" ] || continue
        local rel="${f#$src/}"
        # Only flag genuinely long headings (>120 chars after the # markers).
        while IFS=: read -r ln len snippet; do
            emit WARNING LONG-HEADING "$rel:$ln" \
                "Heading is $len characters; very long headings wrap over many visual" \
                "lines in the PDF and stress coalesce_wrapped (the wrap-merging logic)." \
                "First 60 chars: ${snippet}..."
        done < <(awk '
            /^#{1,4} / {
                hashes = $1
                content_start = length(hashes) + 2
                content = substr($0, content_start)
                if (length(content) > 120) {
                    print NR ":" length(content) ":" substr(content, 1, 60)
                }
            }' "$f")
    done
}

check_no_trailing_newline() {
    should_run NO-TRAILING-NEWLINE || return 0
    local src="$1" f
    for f in "$src"/*.md; do
        [ -f "$f" ] || continue
        local rel="${f#$src/}"
        local last
        last=$(tail -c 1 "$f" | xxd -p)
        if [ "$last" != "0a" ] && [ -n "$last" ]; then
            if [ "$FIX" -eq 1 ]; then
                printf '\n' >> "$f"
                emit FIXED NO-TRAILING-NEWLINE "$rel" "Appended trailing newline."
            else
                emit WARNING NO-TRAILING-NEWLINE "$rel" \
                    "File does not end with a newline. Concatenation in collect_sources.py" \
                    "may behave unexpectedly. Fix: re-run with --fix."
            fi
        fi
    done
}

check_heading_deeper_than_h4() {
    should_run HEADING-DEEPER-THAN-H4 || return 0
    local src="$1" f
    for f in "$src"/LLM[0-9][0-9]_*.md; do
        [ -f "$f" ] || continue
        local rel="${f#$src/}"
        local hits
        hits=$(awk '/^#####+ / { print NR }' "$f")
        [ -z "$hits" ] && continue
        local first count
        first=$(echo "$hits" | head -1)
        count=$(echo "$hits" | wc -l | tr -d ' ')
        emit WARNING HEADING-DEEPER-THAN-H4 "$rel:$first" \
            "Found $count heading(s) at h5 or deeper. headers.py only includes h2 and" \
            "h3 in the TOC; h4+ render but do not appear in the table of contents." \
            "Often signals an off-by-one structural issue."
    done
}

# --- markdownlint integration ---------------------------------------------

run_markdownlint() {
    should_run MARKDOWNLINT || return 0
    local src="$1"
    local fix_arg=""
    [ "$FIX" -eq 1 ] && fix_arg="--fix"
    # Run from src dir so output paths stay short
    local out rc
    # Only lint LLM*.md — ADD*.md files (cover/TOC/figures/supplemental) use
    # intentional non-standard heading structure for visual styling and would
    # produce false positives on rules like MD001.
    out=$(cd "$src" && markdownlint-cli2 $fix_arg --config "$MARKDOWNLINT_CONFIG" "LLM*.md" 2>&1)
    rc=$?
    [ "$rc" -eq 0 ] && return 0

    # markdownlint findings are stylistic — they don't break PDF generation
    # so we surface them as WARNINGs. Most are auto-fixable via --fix.
    # Use process substitution (not pipe) so emit's counter increments survive.
    while IFS= read -r line; do
        local file_loc rule_part msg_part
        file_loc=$(echo "$line" | awk '{print $1}')
        rule_part=$(echo "$line" | awk '{print $2}')
        msg_part=$(echo "$line" | cut -d' ' -f3-)
        emit WARNING "$rule_part" "$file_loc" "$msg_part"
    done < <(echo "$out" | grep -E '\.md:[0-9]+')

    # Catch errors that aren't finding lines (config errors, etc.) — those ARE errors.
    while IFS= read -r line; do
        [ -z "$line" ] && continue
        emit ERROR MARKDOWNLINT-CONFIG "(global)" "$line"
    done < <(echo "$out" | grep -vE '\.md:[0-9]+|^markdownlint-cli2|^Finding|^Linting|^Summary|^$')
}

# --- run everything for one language ---------------------------------------

run_language() {
    local lang="$1"
    local src="$REPO_ROOT/2_0_vulns/translations/$lang"
    LANG_CURRENT="$lang"   # used by emit() for GitHub annotation paths
    LANG_ERR=0; LANG_WARN=0; LANG_FIXED=0

    echo
    echo "=== $lang ==="
    if [ ! -d "$src" ]; then
        emit ERROR MISSING-DIR "$src" "Translation directory does not exist."
        TOTAL_ERR=$((TOTAL_ERR + LANG_ERR))
        return 1
    fi

    # Order matters when --fix:
    # - BOM strip first (so chapter-title-level sees the real first char)
    # - then chapter-title-level (whole-file demote — must precede heading checks
    #   that look at specific levels)
    # - then indented-prose (independent)
    # - then leading-ws-heading and trailing-newline
    # - then markdownlint last (some of its --fix changes overlap with ours;
    #   running after means our fixes are authoritative for the rules we own)
    check_missing_files          "$src"
    check_bom                    "$src"
    check_chapter_title_level    "$src"
    check_indented_prose         "$src"
    check_styles_css_hierarchy   "$src"
    check_leading_ws_heading     "$src"
    check_no_trailing_newline    "$src"
    check_heading_deeper_than_h4 "$src"
    check_long_heading           "$src"
    run_markdownlint             "$src"

    # Per-language summary
    if [ "$LANG_ERR" -gt 0 ] || [ "$LANG_WARN" -gt 0 ] || [ "$LANG_FIXED" -gt 0 ]; then
        echo
        printf "  %s%d error(s)%s, %s%d warning(s)%s" \
            "$C_RED" "$LANG_ERR" "$C_OFF" "$C_YEL" "$LANG_WARN" "$C_OFF"
        [ "$LANG_FIXED" -gt 0 ] && printf ", %s%d fixed%s" "$C_GRN" "$LANG_FIXED" "$C_OFF"
        echo
    else
        echo "  ${C_GRN}clean${C_OFF}"
    fi

    TOTAL_ERR=$((TOTAL_ERR + LANG_ERR))
    TOTAL_WARN=$((TOTAL_WARN + LANG_WARN))
    TOTAL_FIXED=$((TOTAL_FIXED + LANG_FIXED))
}

# --- main loop -------------------------------------------------------------

for lang in "${LANG_CODES[@]}"; do
    run_language "$lang"
done

# --- when --fix: re-run validation read-only to report leftovers -----------

if [ "$FIX" -eq 1 ] && [ "$TOTAL_FIXED" -gt 0 ]; then
    echo
    echo "${C_DIM}--- re-validating after auto-fix ---${C_OFF}"
    FIX=0
    TOTAL_ERR=0; TOTAL_WARN=0; TOTAL_FIXED=0
    for lang in "${LANG_CODES[@]}"; do
        run_language "$lang"
    done
fi

# --- final summary + exit code ---------------------------------------------

echo
if [ "$TOTAL_ERR" -gt 0 ]; then
    echo "${C_RED}Validation failed: $TOTAL_ERR error(s), $TOTAL_WARN warning(s)${C_OFF}"
    exit 1
elif [ "$TOTAL_WARN" -gt 0 ]; then
    echo "${C_YEL}Validation passed with $TOTAL_WARN warning(s)${C_OFF}"
    exit 0
else
    echo "${C_GRN}Validation passed cleanly${C_OFF}"
    exit 0
fi
