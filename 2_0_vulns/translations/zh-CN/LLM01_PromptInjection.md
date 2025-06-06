## LLM01:2025 提示词注入

### 描述

提示词注入漏洞发生在用户以未预期的方式改变大型语言模型（LLM）的行为或输出时。这些输入甚至可能对人类来说是不明显的，但模型能够解析它们并据此改变行为。因此，提示词注入不需要是人类可见或可读的，只要内容被模型解析即可。

提示词注入漏洞存在于模型处理提示词的方式中，以及输入如何迫使模型错误地将提示词数据传递到模型的其他部分，可能使其违反指南、生成有害内容、启用未经授权的访问或影响关键决策。虽然诸如检索增强生成（RAG）和微调等技术旨在使LLM输出更相关和准确，但研究显示它们并不能完全缓解提示词注入漏洞。

尽管提示词注入和越狱在LLM安全领域中是相关的概念，但它们常常被互换使用。提示词注入涉及通过特定输入操纵模型响应以改变其行为，这可能包括绕过安全措施。越狱是一种提示词注入的形式，攻击者提供的输入导致模型完全忽视其安全协议。开发者可以构建防护措施到系统提示词和输入处理中，以帮助缓解提示词注入攻击，但有效预防越狱需要对模型的训练和安全机制进行持续更新。

### 提示词注入漏洞类型

#### 直接提示词注入

直接提示词注入发生在用户提示词输入直接改变模型行为在未预期或意外的方式时。输入可以是故意的（即恶意行为者精心制作提示词以利用模型）或非故意的（即用户无意中提供触发意外行为的输入）。

#### 间接提示词注入

间接提示词注入发生在LLM接受来自外部来源（如网站或文件）的输入时。这些内容可能包含当被模型解析时，会改变模型行为在未预期或意外方式的数据。与直接注入一样，间接注入可以是故意的或非故意的。

成功提示词注入攻击的影响严重性和性质很大程度上取决于模型运作的业务环境以及模型的设计自主性。一般来说，提示词注入可能导致不受期望的结果，包括但不限于：

- 敏感信息泄露

- 揭露关于AI系统基础设施或系统提示词的敏感信息

- 内容操纵导致不正确或有偏见的输出

- 为LLM提供未经授权的功能访问

- 执行连接系统的任意命令

- 操纵关键决策过程

多模态AI的兴起，即同时处理多种数据类型的系统，引入了独特的提示词注入风险。恶意行为者可能利用模态之间的交互，例如在伴随良性文本的图像中隐藏指令。这些系统的复杂性扩大了攻击面。多模态模型也可能容易受到难以检测和缓解的新型跨模态攻击。开发针对多模态特定防御是进一步研究和发展的重要领域。

### 预防和缓解策略

提示词注入漏洞是由于生成式AI的本质而可能出现的。鉴于模型工作方式中的随机影响，目前尚不清楚是否存在预防提示词注入的绝对方法。然而，可以采取以下措施来减轻提示词注入的影响：

1. **约束模型行为**

   在系统提示词中提供关于模型角色、能力和限制的具体指示。强制严格执行上下文依从性，限制响应特定任务或主题，并指示模型忽略修改核心指令的尝试。

2. **定义和验证预期输出格式**

   明确规定输出格式，要求详细推理和引用来源，并使用确定性代码验证对这些格式的遵守。

3. **实施输入和输出过滤**

   定义敏感类别并构建规则以识别和处理此类内容。应用语义过滤器，并使用字符串检查扫描不允许的内容。通过RAG三角评估上下文相关性、基于事实性和问题/答案相关性，以识别潜在恶意输出。

4. **执行特权控制和最小权限访问**

   为应用程序提供自己的API令牌以实现可扩展功能，并在代码中处理这些功能而不是提供给模型。限制模型的访问权限至其操作所需的最低必要级别。

5. **要求对高风险行动进行人工审批**

   对特权操作实施人机协作控制，以防未经授权的操作。

6. **隔离和识别外部内容**

   将不受信任的内容分开并明确标记，以限制其对用户提示词的影响。

7. **进行对抗性测试和攻击模拟**

   定期进行渗透测试和漏洞模拟，将模型视为不受信任的用户，以测试信任边界和访问控制的有效性。

### 示例攻击场景

#### 场景 #1：直接注入

攻击者向客户支持聊天机器人注入提示词，指示其忽略先前指南、查询私人数据存储并发送电子邮件，导致未经授权的访问和特权升级。

#### 场景 #2：间接注入

用户使用LLM总结包含隐藏指令的网页内容，这些指令导致LLM插入链接到URL的图像，从而导致私人对话的外泄。

#### 场景 #3：非故意注入

公司在求职描述中包含识别AI生成申请的指示。申请人不知情地使用LLM优化简历，无意中触发了AI检测。

#### 场景 #4：有意模型影响

攻击者修改仓库中的文档，该仓库被检索增强生成（RAG）应用程序使用。当用户查询返回修改后的内容时，恶意指令会改变LLM的输出，产生误导性结果。

#### 场景 #5：代码注入

攻击者利用漏洞（如CVE-2024-5184）在LLM驱动的电子邮件助手中注入恶意提示词，允许访问敏感信息并操纵电子邮件内容。

#### 场景 #6：负载分割

攻击者上传包含分割恶意指令的简历。当LLM用于评估候选人时，组合指令会操纵模型的响应，导致尽管实际简历内容不符，但仍产生积极推荐。

#### 场景 #7：多模态注入

攻击者将恶意提示词嵌入到伴随良性文本的图像中。当多模态AI同时处理图像和文本时，隐藏的提示词会改变模型行为，可能導致未经授权的操作或敏感信息泄露。

#### 场景 #8：对抗性后缀

攻击者在提示词末尾附加看似无意义的字符串，影响LLM输出，绕过安全措施。

#### 场景 #9：多语言/混淆攻击

攻击者使用多种语言或编码恶意指令（如Base64或表情符号）以规避过滤器并操纵LLM行为。

### 参考链接

1. [ChatGPT插件漏洞 - 与代码聊天](https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/) **Embrace the Red**

2. [ChatGPT跨插件请求伪造和提示词注入](https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./) **Embrace the Red**

3. [并非你所签署的：利用间接提示词注入破坏现实世界中的LLM集成应用](https://arxiv.org/pdf/2302.12173.pdf) **Arxiv**

4. [通过自我提醒防御ChatGPT越狱攻击](https://www.researchsquare.com/article/rs-2873090/v1) **Research Square**

5. [针对LLM集成应用的提示词注入攻击](https://arxiv.org/abs/2306.05499) **Cornell University**

6. [注入我的PDF：简历中的提示词注入](https://kai-greshake.de/posts/inject-my-pdf) **Kai Greshake**

7. [并非你所签署的：利用间接提示词注入破坏现实世界中的LLM集成应用](https://arxiv.org/pdf/2302.12173.pdf) **Cornell University**

8. [威胁建模LLM应用程序](https://aivillage.org/large%20language%20models/threat-modeling-llm/) **AI Village**

9. [通过设计减少提示词注入攻击的影响](https://research.kudelskisecurity.com/2023/05/25/reducing-the-impact-of-prompt-injection-attacks-through-design/) **Kudelski Security**

10. [对抗性机器学习：攻击和缓解措施的分类与术语](https://nvlpubs.nist.gov/nistpubs/ai/NIST.AI.100-2e2023.pdf)

11. [针对大型视觉语言模型的攻击：资源、进展及未来趋势调查](https://arxiv.org/abs/2407.07403)

12. [利用标准安全攻击探索LLMs的程序化行为：双重用途](https://ieeexplore.ieee.org/document/10579515)

13. [对齐语言模型上的通用和可转移对抗性攻击](https://arxiv.org/abs/2307.15043)

14. [从ChatGPT到威胁GPT：生成式AI在网络安全与隐私领域的影响力](https://arxiv.org/abs/2307.00691)

### 相关框架和分类法

参考此部分以获取全面的信息、场景策略以及关于基础设施部署、环境控制和其他最佳实践。

- [AML.T0051.000 - LLM提示词注入：直接](https://atlas.mitre.org/techniques/AML.T0051.000) **MITRE ATLAS**

- [AML.T0051.001 - LLM提示词注入：间接](https://atlas.mitre.org/techniques/AML.T0051.001) **MITRE ATLAS**

- [AML.T0054 - LLM越狱注入：直接](https://atlas.mitre.org/techniques/AML.T0054) **MITRE ATLAS**
