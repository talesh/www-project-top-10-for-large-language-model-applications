LLM03: Envenenamento dos Dados de Treinamento


O ponto de partida de qualquer abordagem de machine learning é o conjunto de dados de treinamento, simplesmente "texto bruto". Para ser altamente capaz (por exemplo, ter conhecimento linguístico e do mundo), esse texto deve abranger uma ampla gama de domínios, gêneros e idiomas. Um modelo de linguagem de grande porte usa redes neurais profundas para gerar outputs com base em padrões aprendidos a partir dos dados de treinamento.
O envenenamento de dados de treinamento refere-se à manipulação dos dados ou do processo de ajuste fino para introduzir vulnerabilidades, portas dos fundos ou tendências que possam comprometer a segurança, eficácia ou comportamento ético do modelo. Informações envenenadas podem ser expostas aos usuários ou criar outros riscos, como degradação de desempenho, exploração de software downstream e danos à reputação. Mesmo que os usuários desconfiem do output problemático da IA, os riscos permanecem, incluindo a redução das capacidades do modelo e o possível dano à reputação da marca.
O envenenamento de dados é considerado um ataque à integridade, pois a adulteração dos dados de treinamento afeta a capacidade do modelo de produzir previsões corretas. Naturalmente, fontes de dados externas apresentam um risco ainda maior, pois os desenvolvedores do modelo não têm controle sobre os dados ou um alto nível de confiança de que o conteúdo não contém viés, informações falsificadas ou conteúdo inadequado.


Exemplos Comuns desta Vulnerabilidade


1. Um ator malicioso ou uma marca concorrente cria intencionalmente documentos imprecisos ou maliciosos direcionados aos dados de treinamento de um modelo.
1. O modelo vítima é treinado usando informações falsificadas que são refletidas nos outputs de prompts de IA generativo para seus consumidores.
2. Um modelo é treinado usando dados que não foram verificados por sua fonte, origem ou conteúdo.
3. O próprio modelo, quando situado na infraestrutura, tem acesso irrestrito ou sandbox inadequado para coletar conjuntos de dados a serem usados como dados de treinamento, o que tem influência negativa nos outputs de prompts de IA generativos, bem como perda de controle do ponto de vista de gerenciamento.


Seja um desenvolvedor, cliente ou consumidor geral do LLM, é importante entender as implicações de como essa vulnerabilidade pode refletir riscos em sua aplicação LLM ao interagir com um LLM não proprietário.


Exemplo de Cenários de Ataques


1. O output do prompt de IA generativo do LLM pode induzir os usuários do aplicativo a ter opiniões enviesadas, seguidores ou até mesmo crimes de ódio.
2. Se os dados de treinamento não forem filtrados ou higienizados corretamente, um usuário mal-intencionado do aplicativo pode tentar influenciar e injetar dados tóxicos no modelo para que ele se adapte aos dados enviesados e falsos.
3. Um ator malicioso ou um concorrente cria intencionalmente documentos imprecisos ou maliciosos direcionados aos dados de treinamento de um modelo que está sendo treinado ao mesmo tempo com base em entradas. O modelo vítima é treinado usando essas informações falsificadas, que são refletidas nas saídas de prompts de IA generativos para seus consumidores.
4. A vulnerabilidade de Injeção de Prompt poderia ser um vetor de ataque para essa vulnerabilidade se não houver uma higienização e filtragem suficientes ao usar entradas de clientes da aplicação LLM para treinar o modelo. Ou seja, se dados maliciosos ou falsificados forem inseridos no modelo por um cliente como parte de uma técnica de injeção de prompt, isso poderia ser inerentemente retratado nos dados do modelo.


Prevenção


1. Verifique a cadeia de suprimentos dos dados de treinamento, especialmente quando obtidos externamente, e mantenha atestados, semelhantes à metodologia "SBOM" (Software Bill of Materials).
2. Verifique a legitimidade correta das fontes de dados segmentadas e dos dados obtidos durante as etapas de treinamento e ajuste fino.
3. Verifique o caso de uso para o LLM e a aplicação à qual ele se integrará. Crie diferentes modelos por meio de dados de treinamento ou ajuste fino separados para diferentes casos de uso, a fim de criar uma saída de IA generativa mais granular e precisa de acordo com o caso de uso definido.
4. Garanta que o sandboxing adequado esteja presente para impedir que o modelo colete fontes de dados não intencionais que possam prejudicar o output de aprendizagem da máquina.
5. Use filtros rigorosos ou filtros de entrada para dados de treinamento específicos ou categorias de fontes de dados para controlar o volume de dados falsificados. Realize a higienização dos dados, com técnicas como detecção de outliers estatísticos e métodos de detecção de anomalias, para detectar e remover dados adversários que possam ser alimentados ao processo de ajuste fino.
6. Técnicas de robustez adversaria, como aprendizado federado e restrições, para minimizar o efeito de outliers ou treinamento adversário para ser vigoroso contra, no pior caso perturbações dos dados de treinamento.
1. Uma abordagem "MLSecOps" poderia ser incluir a robustez adversaria no ciclo de vida de treinamento com a técnica de envenenamento automático.
2. Um exemplo de repositório disso seria o teste Autopoison, incluindo ataques como Ataques de Injeção de Conteúdo ("como injetar sua marca nas respostas do LLM") e Ataques de Recusa ("sempre fazer o modelo recusar a responder") que podem ser realizados com essa abordagem.
7. Teste e Detecção, medindo a perda durante a fase de treinamento e analisando modelos treinados para detectar sinais de um ataque de envenenamento, analisando o comportamento do modelo em entradas de teste específicas.
1. Monitoramento e alerta sobre o número de respostas distorcidas que excedem um limite.
2. Uso de um loop humano para revisar respostas e realizar auditoria.
3. Implementar LLMs dedicados para benchmarking contra consequências indesejadas e treinar outros LLMs usando técnicas de aprendizado por reforço.
4. Realizar exercícios de red team baseados em LLM ou análise de vulnerabilidades de LLM nas fases de teste do ciclo de vida do LLM.




Links de Referência


1. Artigo de Pesquisa da Stanford: https://stanford-cs324.github.io/winter2022/lectures/data/
2. Como os ataques de envenenamento de dados corrompem modelos de aprendizado de máquina: https://www.csoonline.com/article/570555/how-data-poisoning-attacks-corrupt-machine-learning-models.html
3. MITRE ATLAS (framework) Tay Poisoning: https://atlas.mitre.org/studies/AML.CS0009/
4. PoisonGPT: Como escondemos um LLM lobotomizado no Hugging Face para espalhar notícias falsas: https://blog.mithrilsecurity.io/poisongpt-how-we-hid-a-lobotomized-llm-on-hugging-face-to-spread-fake-news/
5. Inject My PDF: Injeção de Prompt para seu Currículo: https://kai-greshake.de/posts/inject-my-pdf/
6. Ataques de Porta dos Fundos em Modelos de Linguagem: https://towardsdatascience.com/backdoor-attacks-on-language-models-can-we-trust-our-models-weights-73108f9dcb1f
7. Envenenamento de Modelos de Linguagem Durante a Instrução: https://arxiv.org/abs/2305.00944
8. FedMLSecurity: https://arxiv.org/abs/2306.04959
9. O envenenamento do ChatGPT: https://softwarecrisis.dev/letters/the-poisoning-of-chatgpt/




