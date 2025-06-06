## LLM07:2025 系統提示洩漏

### 描述

**系統提示洩漏** (System Prompt Leakage) 是指 LLM (大型語言模型) 的系統提示或指令中，包含不應被外界發現的敏感資訊，導致該資訊可能被惡意取得並利用的風險。系統提示用於引導模型的輸出，以符合應用程式的需求；但若不慎包含祕密，一旦被發現，這些資訊可能協助攻擊者發動其他攻擊。

需理解的是，系統提示本身不應被視為機密，也不應作為安全控管手段。因此，像是認證資訊、連線字串等敏感資料不應直接置入系統提示中。

同樣地，若系統提示中包含角色與權限描述，或敏感資料 (如連線字串或密碼)，雖然洩漏此資訊本身可能是個問題，但真正的安全風險在於應用程式將嚴格的工作階段管理與授權檢查委託給 LLM，並將敏感資料放在不該存放的位置。

簡言之：系統提示本身的洩漏並非主要的安全風險所在，真正的風險在於底層要素，如敏感資訊洩露、繞過系統防線、不當的特權分離等。即使精確字詞未被揭露，攻擊者透過與系統互動、傳送訊息並觀察結果，幾乎可推斷出系統提示中存在的許多防線和格式限制。

### 常見風險實例

#### 1. 敏感功能曝光

應用程式的系統提示可能洩露本應保持機密的敏感資訊或功能，如系統架構、API Key、資料庫憑證、使用者 Token。攻擊者取得這些資訊後，可未經授權存取應用程式。例如，一個系統提示中包含所用資料庫類型的資訊，讓攻擊者更精準地對該資料庫進行 SQL Injection 攻擊。

#### 2. 內部規則曝光

系統提示揭露應該保密的內部決策流程，使攻擊者得以窺見應用程式的運作原理，並利用其弱點繞過控制機制。例如，一個銀行應用程式的聊天機器人系統提示中寫道：
>「使用者每日交易上限為 5000 美元，總貸款額度為 10000 美元。」

攻擊者可利用此資訊嘗試繞過既定限制，執行超過限額的交易或超過總貸款額度的行為。

#### 3. 過濾條件揭露

系統提示可能要求模型過濾或拒絕敏感內容。例如：
>「若使用者要求查詢其他用戶資訊，請一律回覆：『抱歉，我無法協助此請求』。」

#### 4. 權限與使用者角色外洩

系統提示可能透露應用程式內部的角色結構或權限等級。例如：
>「Admin 使用者角色具有修改使用者紀錄的完整存取權限。」

攻擊者若得知此類角色與權限分配的方式，可能嘗試特權提升攻擊。

### 預防與緩解策略

#### 1. 將敏感資料與系統提示分離

避免在系統提示中直接嵌入敏感資訊 (如 API Key、驗證金鑰、資料庫名稱、使用者角色、應用程式權限結構)。應將此類資訊外部化，放置於模型無法直接存取的系統中。

#### 2. 避免依賴系統提示進行嚴格行為控管

由於 LLM 容易受到 Prompt Injection 等攻擊影響，建議不要仰賴系統提示作為控制模型行為的主要方式。應於 LLM 外部確保行為的安全性與合規性。例如，偵測與阻止有害內容的工作應在外部系統中完成。

#### 3. 實施外部防護機制 (Guardrails)

在 LLM 本身外建立防護機制。雖然可透過訓練模型不洩漏系統提示來加強安全，但並非保證模型永遠遵從。建立獨立系統檢查模型輸出，確保其符合預期，比僅仰賴系統提示指令更可靠。

#### 4. 確保安全控管獨立於 LLM

關鍵的安全控管 (如特權分離、授權界線檢查) 不應交由 LLM 或系統提示處理。此類控管必須在可稽核且確定的方式下執行，而 LLM 目前並不適合此任務。若代理要執行不同等級存取的任務，應使用多個代理並各自賦予最小必要權限。

### 攻擊情境範例

#### 情境 #1

LLM 的系統提示中包含用於存取某工具的憑證。該系統提示洩漏後，攻擊者可利用這些憑證執行其他惡意操作。

#### 情境 #2

LLM 的系統提示中禁止產生攻擊性內容、外部連結與程式碼執行。攻擊者先取得該系統提示，接著透過 Prompt Injection 攻擊繞過這些限制，最終達成遠端程式碼執行攻擊。

### 參考連結

1. [SYSTEM PROMPT LEAK](https://x.com/elder_plinius/status/1801393358964994062)：Pliny the prompter
2. [Prompt Leak](https://www.prompt.security/vulnerabilities/prompt-leak)：Prompt Security
3. [chatgpt_system_prompt](https://github.com/LouisShark/chatgpt_system_prompt)：LouisShark
4. [leaked-system-prompts](https://github.com/jujumilk3/leaked-system-prompts)：Jujumilk3
5. [OpenAI Advanced Voice Mode System Prompt](https://x.com/Green_terminals/status/1839141326329360579)：Green_Terminals

### 相關框架與分類法

請參考此區，取得有關基礎架構部署、應用環境控管及其他最佳實務的完整資訊與範例策略。

- [AML.T0051.000 - LLM Prompt Injection: Direct (Meta Prompt Extraction)](https://atlas.mitre.org/techniques/AML.T0051.000) **MITRE ATLAS**
