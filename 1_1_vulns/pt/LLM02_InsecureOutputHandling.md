LLM02: Manipulação Insegura de Output


A Manipulação Insegura de Output é uma vulnerabilidade que surge quando um componente downstream aceita cegamente o output de um modelo de linguagem de grande porte (LLM) sem uma devida análise, como por exemplo, transferir o output do LLM diretamente para funções de backend, privilegiadas ou do lado do cliente. Como o conteúdo gerado pelo LLM pode ser controlado pela entrada de prompt, esse comportamento é semelhante a fornecer aos usuários acesso indireto a funcionalidades adicionais.
A exploração bem-sucedida de uma vulnerabilidade de Manipulação Insegura de Output pode resultar em XSS e CSRF em navegadores da web, bem como SSRF, escalonamento de privilégios ou execução remota de código em sistemas de backend. As seguintes condições podem aumentar o impacto dessa vulnerabilidade:
*  A aplicação concede ao LLM privilégios além do que é destinado aos usuários finais, permitindo o escalonamento de privilégios ou execução remota de código.
*  A aplicação é vulnerável a ataques externos de injeção de prompt, o que poderia permitir que um atacante ganhasse acesso privilegiado ao ambiente de um usuário-alvo.




Exemplos Comuns desta Vulnerabilidade
1. O output do LLM é inserido diretamente em um shell do sistema ou função similar, como exec ou eval, resultando na execução remota de código.
2. JavaScript ou Markdown é gerado pelo LLM e retornado a um usuário. O código é então interpretado pelo navegador, resultando em XSS.


Prevenção
1. Trate o modelo como qualquer outro usuário e aplique validação adequada de entrada nas respostas provenientes do modelo para as funções de backend. Siga as diretrizes OWASP ASVS (Application Security Verification Standard) para garantir uma validação e higienização de entrada eficazes.
2. Codifique a saída do modelo de volta para os usuários para mitigar a execução indesejada de código por JavaScript ou Markdown. O OWASP ASVS fornece orientações detalhadas sobre codificação de output.


Exemplo de Cenários de Ataques


1. Uma aplicação utiliza um plug-in LLM para gerar respostas em um recurso de chatbot. No entanto, a aplicação passa diretamente a resposta gerada pelo LLM para uma função interna responsável por executar comandos de sistema sem uma validação adequada. Isso permite que um adversário manipule o output do LLM para executar comandos arbitrários no sistema subjacente, levando ao acesso não autorizado ou modificações não intencionais no sistema.
2. Um usuário utiliza uma ferramenta de resumo de sites alimentada por um LLM para gerar um resumo conciso de um artigo. O site inclui uma injeção de prompt instruindo o LLM a capturar conteúdo sensível do site ou da conversa do usuário. A partir daí, o LLM pode codificar os dados sensíveis e enviá-los para um servidor controlado pelo adversário.
3. Um LLM permite que os usuários criem consultas SQL para um banco de dados backend por meio de um recurso semelhante a chat. Um usuário solicita uma consulta para excluir todas as tabelas do banco de dados. Se a consulta criada pelo LLM não for analisada, todas as tabelas do banco de dados serão excluídas.
4. Um usuário mal-intencionado instrui o LLM a retornar um payload JavaScript a um usuário, sem controles de higienização. Isso pode ocorrer por meio do compartilhamento de um prompt, um site com injeção de prompt ou um chatbot que aceita prompts de um parâmetro de URL. O LLM então retornaria o payload XSS não higienizado ao usuário. Sem filtros adicionais, além dos esperados pelo próprio LLM, o JavaScript seria executado no navegador do usuário.


Links de Referência
1. Banco de Dados de Vulnerabilidades Snyk - Execução de Código Arbitrária: https://security.snyk.io/vuln/SNYK-PYTHON-LANGCHAIN-5411357
2. Explicação do Exploit do Plugin ChatGPT: Da Injeção de Prompt ao Acesso a Dados Privados: https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
3. Novo ataque de injeção de prompt na versão web do ChatGPT. Imagens Markdown podem roubar seus dados de chat: https://systemweakness.com/new-prompt-injection-attack-on-chatgpt-web-version-ef717492c5c2
4. Não confie cegamente nas respostas do LLM. Ameaças aos chatbots: https://embracethered.com/blog/posts/2023/ai-injections-threats-context-matters/
5. Modelagem de Ameaças em Aplicações LLM: https://aivillage.org/large%20language%20models/threat-modeling-llm/
6. OWASP ASVS - 5 Validação, Higienização e Codificação: https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding




