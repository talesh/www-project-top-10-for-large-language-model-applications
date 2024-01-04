# ﻿OWASP Top 10 for LLM
### Version 1.1
Published: October 16, 2023

## Introduction

The frenzy of interest of Large Language Models (LLMs) following of mass-market pre- trained chatbots in late 2022 has been remarkable. Businesses, eager to harness the potential of LLMs, are rapidly integrating them into their operations and client facing offerings. Yet, the breakneck speed at which LLMs are being adopted has outpaced the establishment of comprehensive security protocols, leaving many applications vulnerable to high-risk issues.

The absence of a unified resource addressing these security concerns in LLMs was evident. Developers, unfamiliar with the specific risks associated with LLMs, were left scattered resources and OWASP’s mission seemed a perfect fit to help drive safer adoption of this technology.

### Who is it for?
Our primary audience is developers, data scientists, and security experts tasked with designing and building applications and plug-ins leveraging LLM technologies. We aim to provide practical, actionable, and concise security guidance to help these professionals navigate the complex and evolving terrain of LLM application security.

### The Making of the List
Creating the OWASP Top 10 for LLM Applications list was a significant undertaking, built on the collective expertise of an international team of nearly 500 experts with over 125 active contributors. Our contributors come from diverse backgrounds, including AI companies, security companies, ISVs, cloud hyperscalers, hardware providers, and academia.

We brainstormed for a month and proposed potential vulnerabilities, with team members writing up 43 distinct threats. Through multiple rounds of voting, we refined these proposals to a concise list of the ten most critical vulnerabilities. Dedicated sub-teams scrutinized each vulnerability and subjected it to public review, ensuring the most comprehensive and actionable final list.

Each of these vulnerabilities, along with examples, prevention tips, attack scenarios, and references, was further scrutinized and refined by dedicated sub-teams and subjected to public review, ensuring the most comprehensive and actionable final list.

### Relating to other OWASP Top 10 Lists
While our list shares DNA with vulnerability types found in other OWASP Top 10 lists, we do not simply reiterate these vulnerabilities. Instead, we delve into the unique implications these vulnerabilities have when encountered in applications utilizing LLMs.

Our goal is to bridge the divide between general application security principles and the specific challenges posed by LLMs. This includes exploring how conventional vulnerabilities may pose different risks or might be exploited in novel ways within LLMs, as well as how traditional remediation strategies need to be adapted for applications utilizing LLMs.

### About Version 1.1
While our list shares DNA with vulnerability types found in other OWASP Top 10 lists, we do not simply reiterate these vulnerabilities. Instead, we delve into these vulnerabilities’ unique implications when encountered in applications utilizing LLMs. Our goal is to bridge the divide between general application security principles and the specific challenges posed by LLMs.

The group’s goals include exploring how conventional vulnerabilities may pose different risks or be exploited in novel ways within LLMs and how developers must adapt traditional remediation strategies for applications utilizing LLMs.

### The Future
The v1.1 of the list will not be our last. We expect to update it on a periodic basis to keep pace with the state of the industry. We will be working with the broader community to push the state of the art, and creating more educational materials for a range of uses. We also seek to collaborate with standards bodies and governments on AI security topics. We welcome you to join our group and contribute.



### Steve Wilson
Project Lead, OWASP Top 10 for LLM Applications
[https://www.linkedin.com/in/wilsonsd](https://www.linkedin.com/in/wilsonsd/)    
Twitter/X: @virtualsteve


### Ads Dawson
v1.1 Release Lead & Vulnerability Entries Lead, OWASP Top 10 for LLM Applications
[https://www.linkedin.com/in/adamdawson0](https://www.linkedin.com/in/adamdawson0/) 
GitHub: @GangGreenTemperTatum



## About this Translation

**Translators**

- **Translator Name**  
[https://www.linkedin.com/in/<translator_linked_in>/](https://www.linkedin.com/in/<translator_linked_in>/)  


In the creation of this translation, we consciously elected to employ only human translators, recognizing the exceptionally technical and critical nature of the OWASP Top Ten for LLMs. The translators listed above not only possess a deep understanding of the original content but also the fluency to make this translation a success.

Talesh Seeparsan
Translations Lead, OWASP Top 10 for LLM Applications
[https://www.linkedin.com/in/talesh/](https://www.linkedin.com/in/talesh/)  



## ﻿OWASP Top 10 for Large Language Model Applications

### LLM01: Prompt Injection
Crafty inputs can manipulate a Large Language Model, causing unintended actions. Direct injections overwrite system prompts, while indirect ones manipulate inputs from external sources.

### LLM02: Insecure Output Handling
This vulnerability occurs when an LLM output is accepted without scrutiny, exposing backend systems. Misuse may lead to severe consequences like XSS, CSRF, SSRF, privilege escalation, or remote code execution.

### LLM03: Training Data Poisoning
This occurs when LLM training data is tampered, introducing vulnerabilities or biases that compromise security, effectiveness, or ethical behavior. Sources include Common Crawl, WebText, OpenWebText, & books.

### LLM04: Model Denial of Service
Attackers cause resource-heavy operations on Large Language Models leading to service degradation or high costs. The vulnerability is magnified due to the resource-intensive nature of LLMs and unpredictability of user inputs.

### LLM05: Supply Chain Vulnerabilities
LLM application lifecycle can be compromised by vulnerable components or services, leading to security attacks. Using third-party datasets, pre- trained models, and plugins can add vulnerabilities.

### LLM06: Sensitive Information Disclosure
LLM’s may reveal confidential data in its responses, leading to unauthorized data access, privacy violations, and security breaches. It’s crucial to implement data sanitization and strict user policies to mitigate this.

### LLM07: Insecure Plugin Design
LLM plugins can have insecure inputs and insufficient access control. This lack of application control makes them easier to exploit and can result in consequences like remote code execution.

### LLM08: Excessive Agency
LLM-based systems may undertake actions leading to unintended consequences. The issue arises from excessive functionality, permissions, or autonomy granted to the LLM-based systems.

### LLM09: Overreliance
Systems or people overly depending on LLMs without oversight may face misinformation, miscommunication, legal issues, and security vulnerabilities due to incorrect or inappropriate content generated by LLMs.

### LLM10: Model Theft
This involves unauthorized access, copying, or exfiltration of proprietary LLM models. The impact includes economic losses, compromised competitive advantage, and potential access to sensitive information.
