LLM09: Dependência Excessiva


A Dependência Excessiva ocorre quando sistemas ou pessoas dependem de LLMs para tomadas de decisão ou geração de conteúdo sem supervisão suficiente. Embora os LLMs possam produzir conteúdo criativo e informativo, eles também podem gerar conteúdo que seja factualmente incorreto, inadequado ou inseguro. Isso é chamado de alucinação ou confabulação e pode resultar em desinformação, má comunicação, questões legais e danos à reputação.
O código-fonte gerado por LLMs pode introduzir vulnerabilidades de segurança despercebidas. Isso representa um risco significativo para a segurança operacional de aplicativos. Esses riscos mostram a importância de processos rigorosos de revisão, com:
* Supervisão
* Mecanismo de validação contínua
* Alerta de riscos


Exemplos Comuns desta Vulnerabilidade


1. LLM fornece informações imprecisas como resposta, causando desinformação.
2. LLM produz texto logicamente incoerente ou sem sentido que, embora gramaticalmente correto, não faz sentido.
3. LLM mescla informações de fontes variadas, criando conteúdo enganoso.
4. LLM sugere código inseguro ou defeituoso, levando a vulnerabilidades quando incorporado a um sistema de software.
5. Falha do provedor em comunicar adequadamente os riscos inerentes aos usuários finais, levando a potenciais consequências prejudiciais.


Prevenção


1. Monitore e revise regularmente as saídas dos LLMs. Use técnicas de auto-consistência ou votação para filtrar texto inconsistente. Comparar várias respostas do modelo para um único prompt pode ajudar a julgar melhor a qualidade e consistência da saída.
2. Compare as respostas do LLM com fontes externas confiáveis. Essa camada adicional de validação pode ajudar a garantir que as informações fornecidas pelo modelo sejam precisas e confiáveis.
3. Aprimore o modelo com ajuste fino ou incorporações para melhorar a qualidade de resposta. Modelos genéricos pré-treinados têm mais chances de produzir informações imprecisas em comparação com modelos ajustados em um domínio específico. Técnicas como engenharia de prompt, ajuste de parâmetros eficientes (PET), ajuste de modelo completo e prompt de corrente de pensamento podem ser empregadas para esse propósito.
4. Implemente mecanismos automáticos de validação que possam verificar a saída gerada em relação a fatos ou dados conhecidos. Isso pode fornecer uma camada adicional de segurança e mitigar os riscos associados às alucinações.
5. Divida tarefas complexas em subtarefas gerenciáveis e atribua-as a diferentes agentes. Isso não apenas ajuda a gerenciar a complexidade, mas também reduz as chances de alucinações, já que cada agente pode ser responsabilizado por uma tarefa menor.
6. Comunique os riscos e limitações associados ao uso de LLMs. Isso inclui o potencial de imprecisões de informação e outros riscos. A comunicação eficaz de riscos pode preparar os usuários para possíveis problemas e ajudá-los a tomar decisões melhor informadas.
7. Crie APIs e interfaces de usuário que incentivem o uso responsável e seguro de LLMs. Isso pode envolver medidas como filtros de conteúdo, avisos aos usuários sobre imprecisões potenciais e rotulagem clara de conteúdo gerado por IA.
8. Ao usar LLMs em ambientes de desenvolvimento, estabeleça práticas e diretrizes de codificação seguras para evitar a integração de possíveis vulnerabilidades.


Exemplo de Cenários de Ataques


1. Uma organização de notícias utiliza amplamente um modelo de IA para gerar artigos jornalísticos. Um ator malicioso explora essa dependência excessiva, alimentando informações enganosas à IA, causando a disseminação de desinformação. A IA inadvertidamente plagiou conteúdo, resultando em questões de direitos autorais e diminuição da confiança na organização.
2. Uma equipe de desenvolvimento de software utiliza um sistema de IA como o Codex para acelerar o processo de codificação. A dependência excessiva nas sugestões da IA introduz vulnerabilidades de segurança na aplicação devido a configurações padrão inseguras ou recomendações inconsistentes com práticas de codificação segura.
3. Uma empresa de desenvolvimento de software usa um LLM para auxiliar desenvolvedores. O LLM sugere uma biblioteca ou pacote de código inexistente, e um desenvolvedor, confiando na IA, integra inadvertidamente um pacote malicioso no software da empresa. Isso destaca a importância de verificar as sugestões da IA, especialmente quando envolve código ou bibliotecas de terceiros.


Links de Referência


1. Compreendendo as Alucinações de LLMs: https://towardsdatascience.com/llm-hallucinations-ec831dcd7786
2. Como as Empresas Devem Comunicar os Riscos dos Grandes Modelos de Linguagem aos Usuários?: https://techpolicy.press/how-should-companies-communicate-the-risks-of-large-language-models-to-users/
3. Um site de notícias usou IA para escrever artigos. Foi um desastre jornalístico: https://www.washingtonpost.com/media/2023/01/17/cnet-ai-articles-journalism-corrections/
4. Alucinações de IA: Pacote de Risco: https://vulcan.io/blog/ai-hallucinations-package-risk
5. Como Reduzir as Alucinações de Grandes Modelos de Linguagem: https://thenewstack.io/how-to-reduce-the-hallucinations-from-large-language-models/
6. Medidas Práticas para Reduzir Alucinações: https://newsletter.victordibia.com/p/practical-steps-to-reduce-hallucination






