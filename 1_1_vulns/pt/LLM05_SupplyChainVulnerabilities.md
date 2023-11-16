LLM05: Vulnerabilidades na Cadeia de Suprimentos


A cadeia de suprimentos em LLMs pode ser vulnerável, impactando a integridade dos dados de treinamento, modelos de aprendizado da máquina e plataformas de implantação. Essas vulnerabilidades podem levar a resultados tendenciosos, violações de segurança ou até mesmo falhas completas no sistema. Tradicionalmente, as vulnerabilidades são focadas em componentes de software, mas a Aprendizagem de Máquina estende isso para os modelos pré-treinados e os dados de treinamento fornecidos por terceiros são suscetíveis a ataques de adulteração e envenenamento.
Por fim, as extensões de plugins LLM podem trazer suas próprias vulnerabilidades. Isso é descrito em LLM - Design de Plugin Inseguro, que aborda a escrita de plugins LLM e fornece informações úteis para avaliar plugins de terceiros.




Exemplos Comuns desta Vulnerabilidade


1. Vulnerabilidades tradicionais no pacote terceirizados, incluindo componentes desatualizados ou obsoletos.
2. Uso de um modelo pré-treinado vulnerável para ajuste fino.
3. Uso de dados envenenados obtidos de forma colaborativa para treinamento.
4. O uso de modelos desatualizados ou obsoletos que não são mais mantidos leva a problemas de segurança.
5. Termos e condições (T&Cs) e políticas de privacidade pouco claras dos operadores do modelo levam aos dados sensíveis do aplicativo ser usados para o treinamento do modelo e à subsequente exposição de informações sensíveis. Isso também pode se aplicar aos riscos do uso de material protegido por direitos autorais pelo fornecedor do modelo.


Prevenção


1. Avalie cuidadosamente as fontes de dados e os fornecedores, incluindo os T&Cs e suas políticas de privacidade, usando apenas fornecedores confiáveis. Garanta que a segurança adequada e auditada de forma independente esteja em vigor e que as políticas do operador do modelo estejam alinhadas com suas políticas de proteção de dados, ou seja, seus dados não são usados para treinar os modelos deles; da mesma forma, busque garantias e medidas legais contra o uso de material protegido por direitos autorais pelos mantenedores do modelo.
2. Use apenas plug-ins respeitáveis e certifique-se de que foram testados para os requisitos de sua aplicação. O Design de Plugin Inseguro do LLM fornece informações sobre os aspectos do LLM durante o design de plug-ins inseguros que você deve testar para mitigar os riscos usando plug-ins de terceirizados.
3. Compreenda e aplique as medidas de mitigação encontradas no OWASP Top Ten's A06:2021 - Componentes Vulneráveis e Desatualizados. Isso inclui a varredura de vulnerabilidades, o gerenciamento e a correção de componentes. Para ambientes de desenvolvimento com acesso a dados sensíveis, aplique esses controles também nesses ambientes.
4. Mantenha um inventário atualizado de componentes usando um Registro de Materiais de Software (SBOM) para garantir que você tenha um inventário atualizado, preciso e assinado para evitar adulteração de pacotes implantados. SBOMs podem ser usados para detectar e alertar sobre novas vulnerabilidades dia-zero rapidamente.
5. No momento da escrita, SBOMs não cobrem modelos, seus artefatos e conjuntos de dados; Se o seu aplicativo LLM usa seu próprio modelo, você deve usar as melhores práticas de MLOps e plataformas que ofereçam repositórios de modelos seguros com rastreamento de dados, modelo e experimento.
6. Você também deve usar a assinatura de modelos e códigos ao usar modelos e fornecedores externos.
7. A detecção de anomalias e testes de robustez adversarial em modelos e dados fornecidos podem ajudar a detectar adulteração e envenenamento, conforme discutido em Treinamento de Dados Envenenados; idealmente, isso deve fazer parte dos pipelines de MLOps; no entanto, essas são técnicas emergentes e podem ser mais facilmente implementadas como parte de exercícios de testes de penetração (red-teaming).
8. Implemente monitoramento suficiente para cobrir varreduras de vulnerabilidades em componentes e ambientes, uso de plug-ins não autorizados e componentes desatualizados, incluindo o modelo e seus artefatos.
9. Implemente uma política de correção para mitigar componentes vulneráveis ou desatualizados. Garanta que o aplicativo dependa de uma versão mantida das APIs e do modelo subjacente.
10. Revise e audite regularmente a Segurança e o Acesso dos fornecedores, garantindo que não haja alterações em sua postura de segurança ou T&Cs.


Exemplo de Cenários de Ataques


1. Um adversário explora uma biblioteca Python vulnerável para comprometer um sistema. Isso ocorreu no primeiro vazamento de dados da Open AI.
2. Um adversário fornece um plugin LLM para pesquisar voos, gerando links falsos que levam a golpes para os usuários do plugin.
3. Um adversário explora o registro de pacotes PyPi para enganar desenvolvedores de modelos a baixar um pacote comprometido e vazar dados ou aumentar privilégios em um ambiente de desenvolvimento do modelo. Isso foi um ataque real.
4. Um adversário envenena um modelo pré-treinado publicamente disponível especializado em análise econômica e pesquisa social para criar uma porta dos fundos que gera desinformação e notícias falsas. Eles implantam isso em um mercado de modelos (por exemplo, HuggingFace) para as vítimas usarem.
5. Um adversário envenena conjuntos de dados publicamente disponíveis para ajudar a criar uma porta dos fundos ao ajustar modelos. A porta dos fundos favorece sutilmente certas empresas em diferentes mercados.
6. Um funcionário comprometido de um fornecedor (desenvolvedor terceirizado, empresa de hospedagem etc.) vaza os dados, modelo ou código, roubando propriedade intelectual.
7. Um operador de LLM altera seus T&Cs e Política de Privacidade para exigir uma exclusão explícita do uso de dados do aplicativo para treinamento do modelo, levando à memorização de dados sensíveis.


Links de Referência


1. Vazamento de Dados do ChatGPT Confirmado enquanto Empresa de Segurança Alerta para Exploração de Componentes Vulneráveis:https://www.securityweek.com/chatgpt-data-breach-confirmed-as-security-firm-warns-of-vulnerable-component-exploitation/
2. Processo de Revisão de Plugins da Open AI: https://platform.openai.com/docs/plugins/review
3. Cadeia de Dependências Comprometida do PyTorch-noturno: https://pytorch.org/blog/compromised-nightly-dependency/
4. PoisonGPT: Como escondemos um LLM lobotomizado no Hugging Face para espalhar notícias falsas: https://blog.mithrilsecurity.io/poisongpt-how-we-hid-a-lobotomized-llm-on-hugging-face-to-spread-fake-news/
5. Exército analisando a possibilidade de 'AI BOMs: https://defensescoop.com/2023/05/25/army-looking-at-the-possibility-of-ai-boms-bill-of-materials/
6. Modos de Falha em Aprendizado de Máquina: https://learn.microsoft.com/en-us/security/engineering/failure-modes-in-machine-learning
7. Compromisso da Cadeia de Suprimentos de ML: https://atlas.mitre.org/techniques/AML.T0010/
8. Transferabilidade em Aprendizado de Máquina: de Fenômenos a Ataques de Caixa Preta usando Amostras Adversárias: https://arxiv.org/pdf/1605.07277.pdf
9. BadNets: Identificando Vulnerabilidades na Cadeia de Suprimentos de Modelos de Aprendizado de Máquina: https://arxiv.org/abs/1708.06733
10. Envenenamento do VirusTotal: https://atlas.mitre.org/studies/AML.CS0002/






