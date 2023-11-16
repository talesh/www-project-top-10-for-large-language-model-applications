LLM01: Injeção de Prompt 


A Vulnerabilidade de Injeção de Prompt ocorre quando um adversário manipula um modelo de linguagem de grande porte (LLM) por meio da manipulação de entradas, fazendo com que o LLM execute de acordo com as intenções do adversário sem saber. Isso pode ser feito diretamente no "jailbreak" do prompt do sistema ou indiretamente por meio de manipulação de entradas externas, potencialmente levando ao vazamento de dados, engenharia social e outros problemas.


* As Injeções de Prompt Diretas, também conhecidas como "jailbreaking", ocorrem quando um usuário mal-intencionado sobrescreve ou revela o prompt do sistema subjacente. Isso pode permitir que os adversários explorem os sistemas de backend interagindo com as funções que estão inseguras e acessando dados de armazenamentos através dos LLM.
* As Injeções de Prompt Indiretas ocorrem quando um LLM aceita entradas de fontes externas que podem ser controladas por um adversário, como sites ou arquivos. O adversário pode incorporar uma injeção de prompt no conteúdo externo, sequestrando o contexto da conversa. Isso faz com que o LLM atue como um "delegado confuso", permitindo que o adversário manipule o usuário ou os sistemas adjacentes que o LLM pode acessar. Além disso, as injeções de prompt indiretas não precisam ser visíveis ou legíveis para humanos, desde que o texto seja analisado pelo LLM.


Os resultados de um ataque bem-sucedido de injeção de prompt podem variar amplamente - desde a solicitação de informações sensíveis até a influência nos processos críticos de tomada de decisão sob a aparência de operação normal.
Em ataques avançados, o LLM pode ser manipulado para imitar uma persona maldosa ou interagir com plug-ins da configuração do usuário. Isso pode resultar na divulgação de dados sensíveis, uso não autorizado dos plug-ins ou engenharia social. Nesses casos, o LLM comprometido ajuda o adversário, transpassando proteções padronizadas e mantendo o usuário inconsciente desta intrusão. Nessas situações, o LLM comprometido age efetivamente como um agente do adversário, avançando nos seus objetivos sem acionar proteções comuns ou alertar o usuário final sobre a intrusão.


Exemplos Comuns desta Vulnerabilidade
1. Um usuário mal-intencionado cria uma injeção de prompt direta no LLM, instruindo-o a ignorar os prompts do sistema do desenvolvedor do aplicativo e, em vez disso, executa um prompt que retorne informações privadas, perigosas ou indesejáveis.
2. Um usuário usa um LLM para resumir uma página da web contendo uma injeção de prompt indireta. Isso faz com que o LLM solicite informações sensíveis ao usuário e execute a exfiltração por meio de JavaScript ou Markdown.
3. Um usuário mal-intencionado faz o upload de um currículo contendo uma injeção de prompt indireta. O documento contém uma injeção de prompt com instruções para fazer o LLM informar aos usuários que este documento é um excelente candidato para uma vaga de emprego. Um usuário interno executa o documento no LLM para resumi-lo. A saída do LLM retorna informações afirmando que este é um excelente documento.
4. Um usuário ativa um plug-in vinculado a um site de comércio eletrônico. Uma instrução maliciosa incorporada em um site visitado explora esse plug-in, levando a realização de compras não autorizadas.
5. Uma instrução ou conteúdo maliciosos incorporados em um site visitado exploram outros plug-ins para enganar os usuários.


Prevenção


As vulnerabilidades de injeção de prompt são possíveis devido à natureza dos LLMs, que não segregam instruções e dados externos uns dos outros. Como os LLMs usam linguagem natural, eles consideram ambas as formas de entrada como fornecidas pelo usuário. Consequentemente, não existe uma prevenção infalível dentro do ambiente de LLM, mas as seguintes medidas podem mitigar o impacto das injeções de prompt:


1. Imponha controle de privilégio no acesso do LLM aos sistemas de backend. Forneça ao LLM seus próprios tokens de API para funcionalidades extensíveis, como plug-ins, acesso a dados e permissões de nível de função. Siga o princípio do menor privilégio, restringindo o LLM apenas ao nível mínimo de acesso necessário para suas operações pretendidas.
2. Implemente um elemento humano nas operações extensíveis. Ao realizar operações privilegiadas, como enviar ou excluir e-mails, faça com que o aplicativo exija que o usuário aprove a ação primeiro. Isso mitigará a oportunidade de uma injeção de prompt indireta realizando ações em nome do usuário sem o conhecimento ou consentimento dele.
3. Segregue o conteúdo externo dos prompts de usuário. Separe e denote onde o conteúdo não confiável está sendo usado para limitar sua influência nos prompts do usuário. Por exemplo, use o ChatML para chamadas de API OpenAI para indicar ao LLM a fonte da entrada do prompt.
4. Estabeleça limites de confiança entre o LLM, fontes externas e funcionalidades extensíveis (por exemplo, plug-ins ou funções downstream). Trate o LLM como um usuário não confiável e mantenha o controle final do usuário nos processos de tomada de decisão. No entanto, um LLM comprometido ainda pode atuar como um intermediário (homem-do-meio) entre as APIs do seu aplicativo e o usuário, pois pode ocultar ou manipular informações antes de apresentá-las ao usuário. Destaque visualmente as respostas potencialmente não confiáveis para o usuário.


Exemplo de Cenários de Ataques 


1. Um adversario realiza uma injeção de prompt direta em um chatbot de suporte baseado em LLM. A injeção contém "esquecer todas as instruções anteriores" e as novas instruções para consultar repositórios de dados privados e explorar vulnerabilidades de pacotes e a falta de validação de saída na função de backend para enviar e-mails. Isso leva à execução remota de código, obtendo acesso não autorizado e escalonamento de privilégios.
2. Um adversario incorpora uma injeção de prompt indireta em uma página da web instruindo o LLM a ignorar instruções anteriores do usuário e usar um plug-in LLM para excluir os e-mails do usuário. Quando o usuário usa o LLM para resumir essa página da web, o plug-in LLM exclui os e-mails do usuário.
3. Um usuário usa um LLM para resumir uma página da web contendo uma injeção de prompt indireta para ignorar instruções anteriores do usuário. Isso faz com que o LLM solicite informações sensíveis ao usuário e execute a exfiltração por meio de JavaScript ou Markdown incorporados.
4. Um usuário mal-intencionado faz o upload de um currículo com uma injeção de prompt. O usuário de backend usa um LLM para resumir o currículo e perguntar se a pessoa é um bom candidato. Devido à injeção de prompt, o LLM diz que sim, apesar do conteúdo real do currículo.
5. Um usuário ativa um plug-in vinculado a um site de comércio eletrônico. Uma instrução maliciosa incorporada em um site visitado explora esse plug-in, levando a compras não autorizadas.


Links de Referência
1. Vulnerabilidades do Plugin ChatGPT - Chat com Código: https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/
2. ChatGPT Cross Plugin Request Forgery and Prompt Injection: https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
3. Defendendo o ChatGPT contra Ataque de Jailbreak via Auto-Lembrete: https://www.researchsquare.com/article/rs-2873090/v1
4. Ataque de Injeção de Prompt contra Aplicativos Integrados com LLM: https://arxiv.org/abs/2306.05499
5. Inject My PDF: Injeção de Prompt para seu Currículo: https://kai-greshake.de/posts/inject-my-pdf/
6. ChatML para Chamadas de API OpenAI: https://github.com/openai/openai-python/blob/main/chatml.md
7. Não é o que você se escreveu - Comprometendo Aplicativos Integrados LLM do Mundo Real com Injeção de Prompt Indireta: https://arxiv.org/pdf/2302.12173.pdf
8. Modelando Ameaças em Aplicativos LLM: http://aivillage.org/large%20language%20models/threat-modeling-llm/
9. Injeções de IA: Injeções de Prompt Diretas e Indiretas e Suas Implicações: https://embracethered.com/blog/posts/2023/ai-injections-direct-and-indirect-prompt-injection-basics/






