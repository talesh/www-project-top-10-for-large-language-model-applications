LLM10: Roubo do Modelo


Esta entrada refere-se ao acesso não autorizado e vazamento de modelos LLM por atores maliciosos ou APTs (Advanced Persistent Threats). Isso ocorre quando os modelos LLM proprietários (sendo propriedade intelectual valiosa) são comprometidos, fisicamente roubados, copiados ou pesos e parâmetros são extraídos para criar um equivalente funcional. O impacto do roubo de modelos LLM pode incluir perda econômica e de reputação da marca, erosão da vantagem competitiva, uso não autorizado do modelo ou acesso não autorizado a informações sensíveis contidas no modelo.
O roubo de LLMs representa uma preocupação significativa de segurança à medida que os modelos de linguagem se tornam cada vez mais poderosos e prevalentes. Organizações e pesquisadores devem priorizar medidas robustas de segurança para proteger seus modelos LLM, garantindo a confidencialidade e a integridade de sua propriedade intelectual. A adoção de um quadro de segurança abrangente, que inclui controles de acesso, criptografia e monitoramento contínuo, é crucial para mitigar os riscos associados ao roubo de modelos LLM e proteger os interesses de indivíduos e organizações que dependem de LLMs.




Exemplos Comuns desta Vulnerabilidade


1. Um adversário explora uma vulnerabilidade na infraestrutura de uma empresa para obter acesso não autorizado a seu repositório de modelos LLM por meio de configuração incorreta em suas configurações de segurança de rede ou aplicativo.
2. Um cenário de ameaça interna em que um funcionário insatisfeito vaza um modelo ou artefatos relacionados.
3. Um adversário consulta a API do modelo usando entradas cuidadosamente elaboradas e técnicas de injeção de prompt para coletar um número suficiente de respostas para criar um modelo sombra.
4. Um adversário malicioso consegue contornar as técnicas de filtragem de entrada do LLM para realizar um ataque de canal lateral e, finalmente, extrair informações de arquitetura e pesos do modelo para um recurso controlado remotamente.
5. O vetor de ataque para extração do modelo envolve consultar o LLM com um grande número de prompts sobre um tópico específico. As respostas do LLM podem então ser usadas para ajustar finamente outro modelo. No entanto, há algumas coisas a serem observadas sobre esse ataque:
   1. O adversário deve gerar um grande número de prompts direcionados. Se os prompts não forem específicos o suficiente, as respostas do LLM serão inúteis.
   2. As respostas dos LLMs às vezes podem conter respostas alucinadas, o que significa que o adversário pode não conseguir extrair o modelo inteiro, já que algumas das respostas podem ser sem sentido.
   3. Não é possível replicar um LLM em 100% por meio da extração de modelo. No entanto, o adversário poderá replicar um modelo parcialmente.
6. O vetor de ataque para replicação funcional do modelo envolve o uso do modelo-alvo por meio de prompts para gerar dados de treinamento sintéticos (uma abordagem chamada "autoinstrução") e, em seguida, usa e ajusta finamente outro modelo fundamental para produzir um equivalente funcional. Isso contorna as limitações da extração baseada em consulta tradicional usada no Exemplo 5 e foi utilizado com sucesso na pesquisa de uso de um LLM para treinar outro LLM. Embora no contexto dessa pesquisa, a replicação do modelo não seja um ataque. A abordagem poderia ser usada por um adversário para replicar um modelo proprietário com uma API pública.


O uso de um modelo roubado, como um modelo sombra, pode ser usado para realizar ataques adversários, incluindo acesso não autorizado a informações sensíveis contidas no modelo ou experimentos não detectados com entradas adversárias para posteriormente executar injeções de prompt avançadas.


Prevenção


1. Implemente controles de acesso robustos (por exemplo, RBAC e princípio do menor privilégio) e mecanismos de autenticação fortes para limitar o acesso não autorizado a repositórios de modelos LLM e ambientes de treinamento.
   1. Isso é especialmente verdadeiro para os três primeiros exemplos comuns, que poderiam causar essa vulnerabilidade devido a ameaças internas, configuração incorreta e/ou controles de segurança fracos sobre a infraestrutura que abriga os modelos LLM, pesos e arquitetura nos quais um ator malicioso poderia infiltrar-se de dentro ou fora do ambiente.
   2. O rastreamento, a verificação e as vulnerabilidades de dependência de gerenciamento de fornecedores são tópicos de foco importantes para prevenir explorações de ataques à cadeia de suprimentos.
2. Restrinja o acesso dos LLMs a recursos de rede, serviços internos e APIs.
   1. Isso é verdadeiro para todos os exemplos comuns, pois abrange riscos e ameaças internas, mas também controla o que a aplicação LLM "tem acesso" e, portanto, poderia ser um mecanismo ou etapa de prevenção para evitar ataques de canal paralelo.
3. Monitore regularmente e audite registros de acesso e atividades relacionadas a repositórios de modelos LLM para detectar e responder prontamente a qualquer comportamento suspeito ou não autorizado.
4. Automatize a implantação de MLOps com fluxos de trabalho de governança, rastreamento e aprovação para reforçar os controles de acesso e implantação dentro da infraestrutura.
5. Implemente controles e estratégias de mitigação para reduzir o risco de técnicas de injeção de prompt causando ataques de canal paralelo.
6. Limite de Taxa de Chamadas da API, quando aplicável, e/ou filtros para reduzir o risco de exfiltração de dados das aplicações LLM ou implementar técnicas para detectar (por exemplo, DLP) atividade de extração de outros sistemas de monitoramento.
7. Implemente treinamento de robustez adversária para ajudar a detectar consultas de extração e reforce as medidas de segurança física.
8. Implemente um framework de marca d'água nas etapas de incorporação e detecção do ciclo de vida de LLMs.


Exemplo de Cenários de Ataques


1. Um adversário explora uma vulnerabilidade na infraestrutura de uma empresa para obter acesso não autorizado ao seu repositório de modelos LLM. O adversário prossegue para vazar os modelos LLM valiosos e os utiliza para lançar um serviço de processamento de linguagem concorrente ou extrair informações sensíveis, causando prejuízos financeiros significativos à empresa original.
2. Um funcionário insatisfeito vaza modelos ou artefatos relacionados. A exposição pública desse cenário aumenta o conhecimento dos adversários para ataques de caixa cinza ou, alternativamente, roubar diretamente a propriedade disponível.
3. Um adversário consulta a API com entradas cuidadosamente selecionadas e coleta um número suficiente de respostas para criar um modelo sombra.
4. Uma falha de controle de segurança está presente na cadeia de suprimentos e leva a vazamentos de dados de informações de modelo proprietário.
5. Um adversário malicioso contorna as técnicas de filtragem de entrada e preâmbulos do LLM para realizar um ataque de canal paralelo e conseguir informações do modelo para um recurso controlado remotamente sob seu controle.


Links de Referência


1. O poderoso modelo de IA de Meta vazou online: https://www.theverge.com/2023/3/8/23629362/meta-ai-language-model-llama-leak-online-misuse
2. Runaway LLaMA | Como o modelo LLaMA da Meta vazou: https://www.deeplearning.ai/the-batch/how-metas-llama-nlp-model-leaked/
3. Eu Sei o Que Você Vê: https://arxiv.org/pdf/1803.05847.pdf
4. D-DAE: Ataques de Extração de Modelo de Defesa-Penetração: https://www.computer.org/csdl/proceedings-article/sp/2023/933600a432/1He7YbsiH4c
5. Um Quadro de Defesa Abrangente Contra Ataques de Extração de Modelo: https://ieeexplore.ieee.org/document/10080996
6. Alpaca: Um Modelo de Seguimento de Instruções Forte e Replicável: https://crfm.stanford.edu/2023/03/13/alpaca.html
7. Como a Marca d'Água Pode Ajudar a Mitigar os Riscos Potenciais dos LLMs?: https://www.kdnuggets.com/2023/03/watermarking-help-mitigate-potential-risks-llms.html
