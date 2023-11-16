LLM07: Design Inseguro de Plug-ins


Os plugins LLM são extensões que, quando habilitadas, são chamadas automaticamente pelo modelo durante as interações com o usuário. Eles são impulsionados pelo modelo e não há controle da aplicação sobre a execução. Além disso, para lidar com limitações no tamanho de contexto, os plugins provavelmente implementam entradas de texto livre no modelo sem validação ou verificação de tipo. Isso permite que um possível adversário construa uma solicitação maliciosa ao plugin, o que pode resultar em uma ampla gama de comportamentos indesejados, incluindo a execução remota de código.
O dano das entradas maliciosas muitas vezes ocorre a partir de controles de acesso insuficientes e da falha no rastreamento da autorização entre os plugins. Controle de acesso inadequado permite que um plugin confie cegamente em outros plugins e assume que o usuário final forneceu as entradas. Esse controle de acesso inadequado pode permitir que entradas maliciosas tenham consequências prejudiciais, que variam desde o vazamento de dados, execução remota de código e escalonamento de privilégios.
Este item concentra-se na criação de plugins LLM em vez de usar plugins de terceiros, que são abordados por LLM-Vulnerabilidades na Cadeia de Suprimentos.




Exemplos Comuns desta Vulnerabilidade


1. Um plugin aceita todos os parâmetros em um único campo de texto em vez de parâmetros de entrada distintos.
2. Um plugin aceita strings de configuração, em vez de parâmetros, que podem substituir configurações inteiras.
3. Um plugin aceita SQL bruto ou declarações de programação em vez de parâmetros.
4. A autenticação é realizada sem autorização explícita de um plugin específico.
5. Um plugin trata todo o conteúdo do LLM como sendo criado inteiramente pelo usuário e executa ações solicitadas sem exigir autorização adicional.


Prevenção


1. Os plugins devem impor uma entrada estritamente parametrizada sempre que possível e incluir verificações de tipo e faixa de entradas. Quando isso não for possível, uma segunda camada de chamadas digitadas deve ser introduzida, analisando as solicitações e aplicando validação e sanitização. Quando a entrada de formato livre deve for aceita devido à semântica da aplicação, ela deve ser cuidadosamente inspecionada para garantir que nenhum método potencialmente prejudicial esteja sendo chamado.
2. Os desenvolvedores de plugins devem aplicar as recomendações da OWASP no ASVS (Padrão de Verificação de Segurança de Aplicativos) para garantir uma validação e sanitização eficazes de entrada.
3. Os plugins devem ser inspecionados e testados minuciosamente para garantir uma validação adequada. Use varreduras nos Teste de Segurança de Aplicativos Estáticos (SAST), bem como Teste de Aplicativos Dinâmicos e Interativos (DAST, IAST) nos pipelines de desenvolvimento.
4. Os plugins devem ser projetados para minimizar o impacto de qualquer exploração dos parâmetros de entrada inseguros, seguindo as Diretrizes de Controle de Acesso OWASP ASVS. Isso inclui controle de acesso de privilégios mínimos, expondo o mínimo possível de funcionalidade, mantendo ainda sua função desejada.
5. Os plugins devem usar identidades de autenticação apropriadas, como OAuth2, para aplicar autorização e controle de acesso eficazes. Além disso, Chaves de API devem ser usadas para fornecer contexto para decisões de autorização personalizadas que reflitam a rota do plugin, em vez do usuário interativo padrão.
6. Exija autorização manual do usuário e confirmação de qualquer ação realizada por plugins sensíveis.
7. Os plugins são tipicamente APIs REST, portanto, os desenvolvedores devem aplicar as recomendações encontradas nas 10 Principais Ameaças de Segurança de API da OWASP - 2023 para minimizar vulnerabilidades genéricas.


Exemplo de Cenários de Ataques


1. Um plugin aceita uma URL base e instrui o LLM a combinar a URL com uma consulta para obter previsões do tempo, que são incluídas no tratamento da solicitação do usuário. Um usuário mal-intencionado pode criar uma solicitação para que a URL aponte para um domínio controlado por eles, o que lhes permite injetar seu próprio conteúdo no sistema LLM por meio de seu domínio.
2. Um plugin aceita uma entrada de formato livre em um único campo que não é validado. Um adversário fornece payloads cuidadosamente elaborados para realizar o reconhecimento através de mensagens de erro. Em seguida, ele explora as vulnerabilidades conhecidas em terceirizados para executar código e realizar o vazamento dos dados ou escalonamento de privilégios.
3. Um plugin usado para recuperar incorporações de um vetor armazena parâmetros de configuração como uma sequência de conexão sem validação. Isso permite que um adversário experimente e acesse outros repositórios de vetores alterando nomes ou parâmetros no host e vaza incorporações às quais eles não deveriam ter acesso.
4. Um plugin aceita cláusulas SQL WHERE como filtros avançados, que são então adicionados à consulta SQL de filtragem. Isso permite que um adversário realize um ataque de SQL.
5. Um adversário usa injeção indireta de prompt para explorar um plugin de gerenciamento de código inseguro, sem validação de entrada e controle de acesso fraco, para transferir a propriedade do repositório e bloquear o usuário de seus repositórios


Links de Referência


1. OpenAI ChatGPT Plugins: https://platform.openai.com/docs/plugins/introduction
2. OpenAI ChatGPT Plugins - Plugin Flow: https://platform.openai.com/docs/plugins/introduction/plugin-flow
3. OpenAI ChatGPT Plugins - Autenticação: https://platform.openai.com/docs/plugins/authentication/service-level
4. OpenAI Semantica Exemplo Busca de Plugin: https://github.com/openai/chatgpt-retrieval-plugin
5. Vulnerabilidades de Plugin : Visite um Website e tenha seu codigo mestre roubado:https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/
6. ChatGPT Plugin Explicado: Da Injeção de Prompt ao Acesso de Dados Privados:https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
7. OWASP ASVS - 5 Validação, Sanitização e Codificação: https://owasp-aasvs4.readthedocs.io/en/latest/V5.html#validation-sanitization-and-encoding
8. OWASP ASVS 4.1 Projeto Geral de Controle de Acesso: https://owasp-aasvs4.readthedocs.io/en/latest/V4.1.html#general-access-control-design
9. OWASP Top 10 Riscos de Segurança de API - 2023: https://owasp.org/API-Security/editions/2023/en/0x11-t10/




