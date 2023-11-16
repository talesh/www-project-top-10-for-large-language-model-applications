LLM02: 不安全的输出处理
不安全的输出处理是当下游组件未经适当审查而盲目接受大型语言模型 (LLM) 输出（例如将 LLM 输出直接传递到后端、特权或客户端功能）时出现的威胁。由于 LLM 生成的内容可以通过提示词输入进行控制，因此此行为类似于为用户提供对附加功能的间接访问。
成功利用不安全输出处理威胁可能会导致 Web 浏览器中出现 XSS 和 CSRF，以及后端系统上的 SSRF、权限升级或远程代码执行。以下情况会增加此威胁的影响: 
● 该应用程序授予 LLM 权限超出最终用户的权限，从而实现权限升级或远程代码执行。
● 该应用程序容易受到外部提示词注入攻击，这可能允许攻击者获得对目标用户环境的特权访问。
威胁的常见示例
1. LLM 输出直接输入到系统 shell 或类似函数（例如 exec 或 eval）中，从而导致远程代码执行。
2. JavaScript 或 Markdown 由 LLM 生成并返回给用户。然后浏览器解释该代码，从而导致 XSS。
如何预防
1. 将模型视为任何其他用户，并对从模型到后端函数的响应进行适当的输入验证。遵循 OWASP ASVS（应用程序安全验证标准）指南以确保有效的输入验证和清理。
2. 将模型输出编码（encode)回给用户，以减少 JavaScript 或 Markdown 执行不需要的代码。请参考OWASP ASVS 提供的有关输出编码的详细指导。
攻击场景示例
         1. 应用程序利用 LLM 插件来生成聊天机器人功能的回答。但是，应用程序直接将 LLM 生成的内容传递到负责执行系统命令的内部函数，而无需进行适当的验证。这允许攻击者操纵 LLM 输出以在底层系统上执行任意命令，从而导致未经授权的访问或意外的系统修改。
2. 用户利用由大语言模型支持的网站摘要工具来生成文章的简明摘要。该网站包含一个提示词注入，指示大语言模型从网站或用户的对话中捕获敏感内容。从那里，被操纵的LLM 可以对敏感数据进行编码并将其发送到攻击者控制的服务器。
3. LLM 允许用户通过类似聊天的功能对后端数据库进行 SQL 查询。用户请求删除所有数据库表的查询。如果 LLM 精心设计的查询没有经过仔细检查，那么所有数据库表都将被删除。
4. 恶意用户指示 LLM 将 JavaScript 有效负载返回给用户，而无需进行清理控制。这可以通过共享提示、提示词注入网站或接受来自 URL 参数的提示的聊天机器人来实现。然后，LLM 会将未经处理的 XSS 负载返回给用户。如果没有额外的过滤器，除了大语言模型本身预期的过滤器之外，JavaScript 将在用户的浏览器中执行。
 
参考链接
1. Snyk 威胁数据库-任意代码执行:  https://security.snyk.io/vuln/SNYK-PYTHON-LANGCHAIN-5411357
2. ChatGPT 插件威胁利用解释: 从提示注入到访问私有数据:  https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
3. ChatGPT 网页版出现新的提示注入攻击。 Markdown 图像可以窃取你的聊天数据:  https://systemweakness.com/new-prompt-injection-attack-on-chatgpt-web-version-ef717492c5c2
4. 不要盲目相信LLM的回答。对聊天机器人的威胁:  https://embracethered.com/blog/posts/2023/ai-injections-threats-context-matters/
5. 威胁建模大语言模型应用程序:  https://aivillage.org/large%20language%20models/threat-modeling-llm/
6. OWASP ASVS - 5 验证、清理和编码:  https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding
