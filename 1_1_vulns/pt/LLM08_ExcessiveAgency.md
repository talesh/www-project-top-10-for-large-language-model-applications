LLM08: Autoridade Excessiva


Um sistema baseado em LLM muitas vezes recebe um grau de autoridade pelo seu desenvolvedor - a capacidade de interagir com outros sistemas e realizar ações de resposta a um prompt. A decisão sobre quais funções invocar também pode ser delegada a um 'agente' de LLM para determinar dinamicamente baseado no prompt de entrada ou na saída do LLM.
A Autoridade Excessiva é a vulnerabilidade que permite que ações prejudiciais sejam realizadas em resposta de saídas inesperadas/ambíguas de um LLM (independentemente do que está causando o mau funcionamento do LLM; seja alucinação/confabulação, injeção direta/indireta de prompt, plugin malicioso, prompts benignos mal projetados ou simplesmente um modelo com desempenho ruim). A causa raiz da Autoridade Excessiva geralmente é um ou mais dos seguintes: funcionalidade excessiva, permissões excessivas ou autonomia excessiva.
A Autoridade Excessiva pode levar a uma ampla gama de impactos no espectro de confidencialidade, integridade e disponibilidade, e depende dos sistemas com os quais um aplicativo baseado em LLM pode interagir.


Exemplos Comuns desta Vulnerabilidade


1. Funcionalidade Excessiva: Um agente de LLM tem acesso a plugins que incluem funções que não são necessárias para a operação pretendida do sistema. Por exemplo, um desenvolvedor precisa conceder a um agente de LLM a capacidade de ler documentos de um repositório, mas o plugin de terceiros que eles escolhem usar também inclui a capacidade de modificar e excluir documentos. Alternativamente, um plugin pode ter sido testado durante uma fase de desenvolvimento e descartado em favor de uma alternativa melhor, mas o plugin original permanece disponível para o agente de LLM.
2. Funcionalidade Excessiva: Um plugin de LLM com funcionalidade em aberto não filtra adequadamente as instruções de entrada para comandos fora do necessário para a operação pretendida da aplicação. Por exemplo, um plugin para executar um comando shell específico não impede corretamente que outros comandos shell sejam executados.
3. Permissões Excessivas: Um plugin de LLM possui permissões em outros sistemas que não são necessárias para a operação pretendida da aplicação. Por exemplo, um plugin destinado a ler dados se conecta a um servidor de banco de dados usando uma identidade que não apenas possui permissões SELECT, mas também permissões UPDATE, INSERT e DELETE.
4. Permissões Excessivas: Um plugin de LLM projetado para executar operações em nome de um usuário acessa sistemas downstream com uma identidade privilegiada genérica. Por exemplo, um plugin para ler o repositório de documentos do usuário atual se conecta ao repositório de documentos com uma conta privilegiada que tem acesso aos arquivos de todos os usuários.
5. Autonomia Excessiva: Um aplicativo ou plugin baseado em LLM falha em verificar e aprovar independentemente ações de alto impacto. Por exemplo, um plugin que permite a exclusão de documentos do usuário realiza exclusões sem qualquer confirmação do usuário.


Prevenção
As seguintes ações podem prevenir a Autoridade Excessiva:




1. Limite os plugins/ferramentas que os agentes de LLM podem conectar, limite apenas às funções mínimas necessárias. Por exemplo, se um sistema baseado em LLM não requer a capacidade de buscar o conteúdo de uma URL, tal plugin não deve ser oferecido ao agente de LLM.
2. Limite as funções implementadas em plugins/ferramentas de LLM ao mínimo necessário. Por exemplo, um plugin que acessa a caixa de correio de um usuário para resumir e-mails pode requerer apenas a capacidade de ler e-mails, portanto, o plugin não deve conter outras funcionalidades, como excluir ou enviar mensagens.
3. Evite funções abertas onde for possível (por exemplo, executar um comando shell, buscar uma URL etc.) e use plugins/ferramentas com funcionalidades mais granulares. Por exemplo, um aplicativo baseado em LLM precisa escrever alguma saída em um arquivo. Se isso fosse implementado usando um plugin para executar uma função shell, o escopo de ações indesejadas é muito grande (qualquer outro comando shell poderia ser executado). Uma alternativa mais segura seria construir um plugin de escrita de arquivo que só suportasse essa funcionalidade específica.
4. Limite as permissões concedidas a plugins/ferramentas de LLM aos sistemas externos apenas ao mínimo necessário para limitar o escopo de ações indesejadas. Por exemplo, um agente de LLM que usa um banco de dados de produtos para fazer recomendações de compra a um cliente pode precisar apenas de acesso de leitura a uma tabela de 'produtos'; ele não deve ter acesso a outras tabelas, nem a capacidade de inserir, atualizar ou excluir registros. Isso deve ser aplicado através de permissões adequadas no banco de dados para a identidade que o plugin LLM usa para se conectar ao banco de dados.
5. Acompanhe a autorização do usuário e o escopo de segurança para garantir que as ações executadas em nome de um usuário sejam realizadas nos sistemas downstream no contexto desse usuário específico e com os privilégios mínimos necessários. Por exemplo, um plugin de LLM que lê o repositório de código de um usuário deve exigir que o usuário se autentique via OAuth e com o escopo mínimo necessário.
6. Utilize controle humano para exigir que um humano aprove todas as ações antes de serem executadas. Isso pode ser implementado em um sistema downstream (fora do escopo do aplicativo LLM) ou dentro do próprio plugin/ferramenta de LLM. Por exemplo, um aplicativo baseado em LLM que cria e posta conteúdo em mídias sociais em nome de um usuário deve incluir um procedimento de aprovação do usuário no plugin/ferramenta/API que implementa a operação de 'postagem'.
7. Implemente autorização em sistemas downstream em vez de depender de um LLM para decidir se uma ação é permitida ou não. Ao implementar ferramentas/plugins, aplique o princípio de mediação completa para que todas as solicitações feitas a sistemas downstream por meio das ferramentas/plugins sejam validadas em relação a políticas de segurança.


As seguintes opções não prevenirão a Autoridade Excessiva, mas podem limitar o nível de dano causado:


1. Registre e monitore a atividade de plugins/ferramentas de LLM e sistemas downstream para identificar onde ações indesejadas estão ocorrendo e responda conforme necessário.
2. Implemente limitação de taxa para reduzir o número de ações indesejadas que podem ocorrer dentro de um determinado período de tempo, aumentando a oportunidade de descobrir ações indesejadas por meio de monitoramento antes que ocorram danos significativos.


Exemplo de Cenários de Ataques


Um aplicativo de assistente pessoal baseado em LLM recebe acesso à caixa de correio de um indivíduo por meio de um plugin para resumir o conteúdo de e-mails recebidos. Para alcançar essa funcionalidade, o plugin de e-mail requer a capacidade de ler mensagens, no entanto, o plugin de terceiros escolhido pelo desenvolvedor do sistema também contém funções para enviar mensagens. O LLM é vulnerável a um ataque indireto de injeção de prompt, em que um e-mail maliciosamente criado engana o LLM a ordenar que o plugin de e-mail chame a função 'enviar mensagem' para enviar spam da caixa de correio do usuário. Isso poderia ser evitado por: (a) eliminar funcionalidades excessivas usando um plugin que ofereça apenas capacidades de leitura de e-mail, (b) eliminar permissões excessivas autenticando-se no serviço de e-mail do usuário por meio de uma sessão OAuth com um escopo somente de leitura e/ou (c) eliminar autonomia excessiva exigindo que o usuário revise manualmente e clique em 'enviar' em cada e-mail redigido pelo plugin LLM. Alternativamente, o dano causado poderia ser reduzido implementando limitação de taxa na interface de envio de e-mails.


Links de Referência


1. Embrace the Red: Problema do Delegado Confuso: https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
2. NeMo-Guardrails Diretrizes de Interface: https://github.com/NVIDIA/NeMo-Guardrails/blob/main/docs/security/guidelines.md
3. LangChain: Aprovação Humana para Ferramentas: https://python.langchain.com/docs/modules/agents/tools/human_approval
4. Simon Willison: Padrão Dual LLM: https://simonwillison.net/2023/Apr/25/dual-llm-pattern/






