LLM07: 不安全的插件设计
 
LLM 插件是扩展，启用后，模型会在用户交互期间自动调用它们。它们由模型驱动，并且应用程序无法控制执行。此外，为了解决上下文大小限制，插件可能会实现来自模型的自由文本输入，而无需验证或类型检查。这使得潜在的攻击者可以构造对插件的恶意请求，这可能会导致各种不良行为，甚至包括远程代码执行。
 
恶意输入的危害通常取决于访问控制不足以及无法跟踪插件之间的授权。不充分的访问控制允许插件盲目信任其他插件并假设最终用户提供了输入。这种不充分的访问控制可能会使恶意输入产生有害后果，包括数据泄露、远程代码执行和权限升级。
 
本项目重点介绍 LLM 插件的创建，而不是使用第三方插件，后者由 LLM-Supply-Chain-Vulnerability 涵盖。
 
威胁的常见示例
 
1. 插件接受单个文本字段中的所有参数，而不是不同的输入参数。
2. 插件接受配置字符串而不是参数，可以覆盖整个配置设置。
3. 插件接受原始 SQL 或编程语句而不是参数。
4. 无需对特定插件进行显式授权即可执行身份验证。
5. 插件将所有 LLM 内容视为完全由用户创建，并执行任何请求的操作，无需额外授权。
 
如何预防
 
1. 插件应尽可能强制执行严格的参数化输入，并包括对输入的类型和范围检查。如果这是不可能的，则应引入第二层类型化调用，解析请求并应用验证和清理。当由于应用程序语义而必须接受自由格式输入时，应仔细检查以确保没有调用任何潜在有害的方法。
2. 插件开发人员应应用 ASVS（应用程序安全验证标准）中的 OWASP 建议，以确保有效的输入验证和清理。
3. 应彻底检查和测试插件，以确保充分验证。在开发管道中使用静态应用程序安全测试 (SAST) 扫描以及动态和交互式应用程序测试（DAST、IAST）。
4. 插件的设计应遵循 OWASP ASVS 访问控制指南，最大限度地减少任何不安全输入参数利用的影响。这包括最小权限访问控制，在仍执行其所需功能的同时暴露尽可能少的功能。
5. 插件应使用适当的身份验证身份（例如 OAuth2）来应用有效的授权和访问控制。此外，API 密钥应用于为自定义授权决策提供上下文，该决策反映插件路由而不是默认的交互用户。
6. 需要手动用户授权并确认敏感插件所采取的任何操作。
7. 插件通常是 REST API，因此开发人员应应用 OWASP Top 10 API 安全风险 – 2023 中的建议来最大程度地减少一般威胁。
 
攻击场景示例
 
1. 插件接受基本 URL 并指示 LLM 将 URL 与查询结合起来以获取处理用户请求时包含的天气预报。恶意用户可以制作一个请求，使 URL 指向他们控制的域，这允许他们通过其控制的域将他们的内容注入到 LLM 系统中。
2. 插件接受不验证的单个字段的自由格式输入。攻击者提供精心设计的有效负载来根据错误消息执行侦察。然后，它利用已知的第三方威胁来执行代码并执行数据泄露或权限升级。
3. 用于从向量存储中检索嵌入的插件接受配置参数作为连接字符串，无需任何验证。这允许攻击者通过更改名称或主机参数来试验和访问其他向量存储，并窃取他们不应访问的嵌入。
4. 插件接受 SQL WHERE 子句作为高级过滤器，然后将其附加到过滤 SQL。这允许攻击者发起 SQL 攻击。
5. 攻击者使用间接提示注入来利用不安全的代码管理插件，该插件没有输入验证且访问控制较弱，以转移存储库所有权并将用户锁定在其存储库之外。
 
参考链接
 
1. OpenAI ChatGPT 插件:  https://platform.openai.com/docs/plugins/introduction
2. OpenAI ChatGPT 插件 - 插件流程:  https ://platform.openai.com/docs/plugins/introduction/plugin-flow
3. OpenAI ChatGPT 插件 - 身份验证:  https://platform.openai.com/docs/plugins/authentication/service-level
4. OpenAI 语义搜索插件示例:  https://github.com/openai/chatgpt-retrieval-plugin
5. 插件威胁: 访问网站并导致源代码被盗:  https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/
6. ChatGPT 插件威胁利用解释: 从提示注入到访问私有数据:  https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
7. OWASP ASVS - 5 验证、清理和编码:  https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding
8. OWASP ASVS 4.1 通用访问控制设计:  https://owasp-aasvs4.readthedocs.io/en/latest/V4.1.html#general-access-control-design
9. OWASP 十大 API 安全风险 – 2023 年:  https://owasp.org/API-Security/editions/2023/en/0x11-t10/
