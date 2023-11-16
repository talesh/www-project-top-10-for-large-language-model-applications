LLM04: Negação de Serviço ao Modelo


Um adversário interage com um LLM de forma a consumir uma quantidade excepcionalmente alta de recursos, resultando em uma queda na qualidade do serviço para ele e outros usuários, bem como possivelmente incorrendo em altos custos de recursos. Além disso, uma preocupação de segurança emergente é a possibilidade de um adversário interferir ou manipular a janela de contexto de um LLM. Esse problema está se tornando mais crítico devido ao uso cada vez maior de LLMs em várias aplicações, sua intensa utilização de recursos, a imprevisibilidade da entrada dos usuários e uma falta geral de conscientização entre os desenvolvedores em relação a essa vulnerabilidade. Nos LLMs, a janela de contexto representa o comprimento máximo de texto que o modelo pode gerenciar, abrangendo tanto a entrada quanto a saída. É uma característica crucial dos LLMs, pois dita a complexidade dos padrões de linguagem que o modelo pode entender e o tamanho do texto que ele pode processar em um determinado momento. O tamanho da janela de contexto é definido pela arquitetura do modelo e pode variar entre os modelos.




Exemplos Comuns desta Vulnerabilidade


1. Fazer consultas que levem a um uso recorrente de recursos por meio da geração de tarefas em fila em grande volume, por exemplo, com LangChain ou AutoGPT.
2. Enviar consultas que consomem recursos de forma incomum, talvez porque usem ortografia ou sequências incomuns.
3. Transbordamento contínuo de entrada: Um adversário envia um fluxo contínuo de entrada para o LLM que excede sua janela de contexto, fazendo com que o modelo consuma recursos computacionais excessivos.
4. Entradas longas repetitivas: O atacante envia repetidamente entradas longas para o LLM, cada uma excedendo a janela de contexto.
5. Expansão recursiva de contexto: O atacante constrói uma entrada que aciona a expansão recursiva de contexto, forçando o LLM a expandir e processar repetidamente a janela de contexto.
6. Inundação de entrada de comprimento variável: O atacante inunda o LLM com um grande volume de entradas de comprimento variável, em que cada entrada é cuidadosamente elaborada para atingir o limite da janela de contexto. Essa técnica visa explorar quaisquer ineficiências no processamento de entradas de comprimento variável, sobrecarregando o LLM e potencialmente tornando-o não responsivo.


Exemplo de Cenários de Ataques


1. Um adversário envia repetidamente várias solicitações a um modelo hospedado que são difíceis e custosas de serem processadas, levando a um pior serviço para outros usuários e custos elevados dos recursos para o host.
2. Um trecho de texto em uma página da web é encontrado enquanto uma ferramenta orientada por um LLM está coletando informações para responder a uma consulta benigna. Isso faz com que a ferramenta faça muito mais solicitações à página da web, resultando em grandes quantidades de consumo de recursos.
3. Um adversário bombardeia continuamente o LLM com entrada que excede sua janela de contexto. O adversário pode usar scripts ou ferramentas automatizados para enviar uma grande quantidade de entrada, sobrecarregando as capacidades de processamento do LLM. Como resultado, o LLM consome recursos computacionais excessivos, levando a uma desaceleração significativa ou a completa falta de resposta do sistema.
4. Um adversário envia uma série de entradas sequenciais ao LLM, sendo que cada entrada é projetada para estar logo abaixo do limite da janela de contexto. Ao enviar repetidamente essas entradas, o atacante visa esgotar a capacidade disponível da janela de contexto. Conforme o LLM luta para processar cada entrada dentro de sua janela de contexto, os recursos do sistema ficam sobrecarregados, podendo resultar em desempenho degradado ou uma negação de serviço completa.
5. Um adversário aproveita os mecanismos recursivos do LLM para desencadear repetidamente a expansão de contexto. Ao criar uma entrada que explora o comportamento recursivo do LLM, o adversário força o modelo a expandir e processar repetidamente a janela de contexto, consumindo recursos computacionais significativos. Esse ataque sobrecarrega o sistema e pode levar a uma condição de negação de serviço, tornando o LLM não responsivo ou causando sua falha.
6. Um adversário inunda o LLM com um grande volume de entradas de comprimento variável, cuidadosamente elaboradas para se aproximar ou atingir o limite da janela de contexto. Ao sobrecarregar o LLM com entradas de comprimentos variados, o atacante visa explorar quaisquer ineficiências no processamento de entradas de comprimento variável. Essa inundação de entradas coloca uma carga excessiva nos recursos do LLM, podendo gerar degradação de desempenho e prejudicar a capacidade do sistema de responder a solicitações legítimas.


Prevenção


1. Implementar validação e higienização de entrada para garantir que a entrada do usuário siga os limites definidos e filtre qualquer conteúdo malicioso.
2. Limitar o uso de recursos por solicitação ou etapa, para que solicitações envolvendo partes complexas sejam executadas mais lentamente.
3. Aplicar limites de taxa de API para restringir o número de solicitações que um usuário individual ou endereço IP pode fazer dentro de um período de tempo específico.
4. Limitar o número de ações em fila e o número total de ações em um sistema que reage a respostas do LLM.
5. Monitorar continuamente a utilização de recursos do LLM para identificar picos ou padrões anormais que possam indicar um ataque de negação de serviço.
6. Definir limites rígidos de entrada com base na janela de contexto do LLM para evitar sobrecarga e exaustão de recursos.
7. Promover a conscientização entre os desenvolvedores sobre vulnerabilidades potenciais de negação de serviço em LLMs e fornecer diretrizes para a implementação segura dos LLMs.


Links de Referência


1. LangChain max_iterations: https://twitter.com/hwchase17/status/1608467493877579777
2. Exemplos de Esponja: Ataques de Energia-Latência em Redes Neurais: https://arxiv.org/abs/2006.03463
3. Ataque de Negação de Serviço OWASP: https://owasp.org/www-community/attacks/Denial_of_Service
4. Aprendendo com Máquinas: Conheça o Contexto: https://lukebechtel.com/blog/lfm-know-thy-context






