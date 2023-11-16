LLM06: Divulgação de Informações Sensíveis


As aplicações LLM têm o potencial de revelar informações sensíveis, algoritmos proprietários ou outros detalhes confidenciais por meio de suas saídas. Isso pode resultar em acesso não autorizado a dados sensíveis, propriedade intelectual, violações de privacidade e outras violações de segurança. É importante que os usuários das aplicações LLM estejam cientes de como interagir com segurança com os LLMs e identificar os riscos associados à entrada acidental de dados sensíveis que podem ser retornados pelo LLM na saída em outros lugares.
Para mitigar esse risco, as aplicações LLM devem realizar uma sanitização adequada dos dados para evitar que os dados do usuário entrem nos dados de treinamento do modelo. Os proprietários de aplicações LLM também devem ter políticas apropriadas de Termos de Uso disponíveis para conscientizar os consumidores sobre como seus dados são processados e a possibilidade de optar por não incluir seus dados no modelo de treinamento.
A interação entre o consumidor e a aplicação LLM forma uma fronteira de confiança bidirecional, onde não podemos confiar inerentemente na entrada cliente->LLM ou na saída LLM->cliente. É importante observar que essa vulnerabilidade pressupõe que certos pré-requisitos estão fora do escopo, como exercícios de modelagem de ameaças, segurança de infraestrutura adequada e sandboxing adequado. Adicionar restrições na solicitação do sistema em torno dos tipos de dados que o LLM deve retornar pode fornecer alguma mitigação contra a divulgação de informações sensíveis, mas a natureza imprevisível dos LLMs significa que tais restrições nem sempre podem ser respeitadas e podem ser contornadas por meio da injeção de prompt ou outros vetores.




Exemplos Comuns desta Vulnerabilidade


1. Filtragem incompleta ou inadequada de informações sensíveis nas respostas dos LLMs.
2. Sob reajuste ou memorização de dados sensíveis no processo de treinamento dos LLMs.
3. Divulgação não intencional de informações confidenciais devido a interpretação incorreta dos LLMs, falta de métodos de limpeza dos dados ou erros.


Prevenção


1. Integre técnicas adequadas de sanitização e limpeza dos dados para evitar que os dados do usuário entrem nos dados de treinamento do modelo.
2. Implemente métodos robustos de validação e sanitização de entrada para identificar e filtrar possíveis entradas maliciosas para evitar que o modelo seja envenenado.
3. Ao enriquecer o modelo com dados e, se estiver realizando ajuste fino (https://github.com/OWASP/www-project-top-10-for-large-language-model-applications/wiki/Definitions) de um modelo: (ou seja, dados fornecidos ao modelo antes ou durante a implantação)
   1. Qualquer informação que seja considerada sensível nos dados de ajuste fino tem o potencial de ser revelada a um usuário. Portanto, aplique a regra do mínimo privilégio e não treine o modelo com informações que o usuário com privilégios mais altos pode acessar, pois pode ser revelado a um usuário com privilégios mais baixos.
   2. O acesso a fontes externas de dados (orquestração de dados em tempo de execução) deve ser limitado.
   3. Aplique métodos rigorosos de controle de acesso a fontes externas de dados e uma abordagem rigorosa para manter uma cadeia de suprimentos segura.


Exemplo de Cenários de Ataques


1. O usuário A legítimo e desprevenido é exposto a dados de outros usuários por meio do LLM ao interagir com a aplicação LLM de maneira não maliciosa.
2. O usuário A direciona um conjunto de solicitações bem elaborado para contornar filtros de entrada e sanitização do LLM e faz com que ele revele informações sensíveis (PII) de outros usuários do aplicativo.
3. Dados pessoais, como PII, vazam para o modelo por meio dos dados de treinamento, devido à negligência do próprio usuário ou à aplicação LLM. Esse caso pode aumentar o risco e a probabilidade dos cenários 1 ou 2 acima.


Links de Referência


1. Crise de Vazamento de Dados de IA: Nova ferramenta impede que segredos da empresa sejam alimentados ao ChatGPT: https://www.foxbusiness.com/politics/ai-data-leak-crisis-prevent-company-secrets-chatgpt
2. Lições aprendidas com o vazamento da Samsung no ChatGPT:https://cybernews.com/security/chatgpt-samsung-leak-explained-lessons/
3. Cohere- Termos de Uso: https://cohere.com/terms-of-use
4. AI Village - Exemplo de Modelagem de Ameaças: https://aivillage.org/large%20language%20models/threat-modeling-llm/
5. Guia de Segurança e Privacidade da IA OWASP: https://owasp.org/www-project-ai-security-and-privacy-guide/




