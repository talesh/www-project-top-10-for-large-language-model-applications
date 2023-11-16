LLM03: Opetusdatan myrkyttäminen


Minkä tahansa koneoppimisratkaisun lähtökohta on opetusdata, eli ns. raakateksti. Jotta malli olisi kyvykäs (esim. tieto kielestä ja ympäröivästä maailmasta), tekstin tulisi kattaa laaja aihealue ja joukko kieliä. Suuri kielimalli käyttää syviä neuroverkostoja generoidakseen vasteita, jotka perustuvat opetusdatasta opittuihin rakenteisiin.


Opetusdatan myrkyttämisellä tarkoitetaan datan tai opetusprosessin manipulointia, jonka avulla voidaan ottaa käyttöön haavoittuvuuksia, takaovia (backdoor) tai vinoumia. Nämä voivat vaarantaa mallin tietoturvan, tehokkuuden tai eettisen käytöksen. Myrkytetty tieto voi nousta pintaan käyttäjille asti, tai se voi luoda muita riskejä kuten suorituskyvyn heikkenemistä, alempana (downstream) olevien järjestelmien hyväksikäyttöä ja mainehaittoja. Vaikka käyttäjät eivät luottaisi ongelmalliseen AI-vasteeseen, riskit kuten mallin heikentyneet kyvyt ja mahdolliset mainehaitat pysyvät.


Datan myrkytystä pidetään hyökkäyksenä eheyttä (integrity) vastaan, koska opetusdatan peukalointi vaikuttaa suoraan mallin kykyyn tehdä oikeita ennusteita. Luonnollisesti ulkoiset datalähteet aiheuttavat suuremman riskin, koska mallin luojat eivät voi vaikuttaa dataan. Mallin luojat eivät myöskään voi luottaa että sisältö ei sisällä vinoumia, väärennettyä tietoa tai sopimatonta sisältöä.
Yleisiä esimerkkejä haavoittuvuudesta


1. Pahantahtoinen tekijä tai kilpaileva brändi luo tahallisesti epätarkkoja tai pahantahtoisia dokumentteja, joiden kohteena on mallin opetusdata.
   1. Kohdemallia opetetaan väärennetyllä tiedolla, joka heijastuu generatiivisen tekoälyn kuluttajille toimittamissa vasteissa
2. Mallia opetetaan datalla jota ei ole verifioitu lähteen, alkuperän tai sisällön suhteen.
3. Infrastruktuurissa sijaitsevaa malliin voidaan päästä käsiksi rajoittamattomasti tai riittämättömän sandboxauksen kautta. Tämän vuoksi malli voi kerätä generatiivisen tekoälyn kehotteisiin negatiivisesti vaikuttavia datasettejä. Tämä aiheuttaa kontrollin menettämisen hallinnoinnin näkökulmasta.


Riippumatta roolista (kehittäjä, asiakas tai suuren kielimallin käyttäjä), on tärkeää ymmärtää tämän haavoittuvuuden seuraukset riskeihin suurta kielimallia käyttävässä ohjelmistossa, sen ollessa vuorovaikutuksessa ei-omistusoikeudellisen mallin kanssa.
Esimerkkejä hyökkäysskenaarioista


1. Suuren kielimallin generatiivisen AI-kehotteen vaste voi johtaa ohjelmiston käyttäjiä harhaan. Tämä voi johtaa vinoutuneisiin mielipiteisiin, seuraamisiin, tai jopa pahimmassa tapauksessa viharikoksiin jne.
2. Jos opetusdataa ei suodateta ja/tai sanitoida oikein, ohjelmiston pahantahtoinen käyttäjä voi yrittää vaikuttaa malliin tai injektoida siihen myrkyllistä dataa. Tämän johdosta malli voi sopeutua vinoutuneeseen, väärään dataan.
3. Pahantahtoinen tekijä tai kilpailija luo tahallisesti epätarkkoja tai pahantahtoisia asiakirjoja, jotka on kohdistettu mallin opetusdataan, joka on juuri käytössä. Uhrina oleva malli oppii väärennetyn tiedon avulla, joka heijastuu kuluttajille päätyviin generatiivisiin kehotteisiin.
4. Kehoteinjektio-tyyppinen haavoittuvuus voi toimia hyökkäysvektorina myös tälle haavoittuvuudelle. Tämä voi tapahtua etenkin, jos suurta kielimallia käyttävän ohjelmiston asiakkaiden syötettä ei sanitoida ja suodateta riittävästi.
Estäminen


1. Tarkista opetusdatan toimitusketju ja siihen liittyvät todistukset, erityisesti silloin kun data on peräisin ulkopuolisista lähteistä. Käytä hyväksi “SBOM” (Software Bill of Materials) -metodologiaa.
2. Tarkista datalähteiden legitiimiys ja lähteiden sisältämä data opetus- ja hienosäätövaiheissa.
3. Tarkista suuren kielimallin ja siihen integroituvan ohjelmiston käyttötapaus. Luo useita malleja erillisellä opetusdatalla tai hienosäädöllä eri käyttötapauksia varten. Näin saadaan luotua hienojakoisempia ja tarkemia generatiivisia vasteita määriteltyjä käyttötapauksia varten.
4. Varmista riittävä sandboxaus, jotta malli ei haravoi (scrape) ei-tarkoitettua dataa lähteiltä, jotka voisivat haitata koneoppimisen tuloksia.
5. Käytä tarkkaa seulontaa tai syötteen suodatusta tietylle opetusdatalle tai joillekin datalähdetyypeille. Tällä tavalla voidaan rajoittaa väärennetyn datan määrää. Datan sanitointi tekniikoilla, kuten tilastollisten poikkeamien (outlier) ja poikkeavuuksien (anomaly) havainnointi, auttaa vihamielisen datan löytämisessä. Lisäksi data voidaan poistaa ennen sen syöttämistä hienosäätöprosessille.
6. Käytä kilpailevia kestävyystekniikoita  (adversarial robustness) kuten federoitu oppiminen ja rajoitteet minimoidaksesi poikkeamien vaikutukset. Käytä kilpailevaa opettamista pahinta opetusdatan häirintää vastaan. 
   1. MLSecOps-lähestymistapa voisi sisällyttää kilpailevaa kestävyyttä opetussykliin automaattisella myrkytystekniikalla.
   2. Esimerkki tästä voisi olla automaattinen myrkytystestaus, joka sisältäisi sisältöinjektio (kuinka injektoida brändisi suuren kielimallin vastauksiin)- ja kieltohyökkäykset (mallin pakottaminen jättämättä vastaamaan). 
7. Testaus ja havainnointi opetusvaiheen 
8. Testing and Detection, by measuring the loss during the training stage and analyzing trained models to detect signs of a poisoning attack by analyzing model behavior on specific test inputs.
   1. a. Monitoring and alerting on the number of skewed responses exceeding a threshold.
   2. b. Use of a human loop to review responses and auditing.
   3. c. Implement dedicated LLMs to benchmark against undesired consequences and train other LLMs using reinforcement learning techniques.
   4. d. Perform LLM-based red team exercises or LLM vulnerability scanning into the testing phases of the LLMs lifecycle.


Reference Links


1. Stanford Research Paper: https://stanford-cs324.github.io/winter2022/lectures/data/
2. How data poisoning attacks corrupt machine learning models: https://www.csoonline.com/article/570555/how-data-poisoning-attacks-corrupt-machine-learning-models.html
3. MITRE ATLAS (framework) Tay Poisoning: https://atlas.mitre.org/studies/AML.CS0009/
4. PoisonGPT: How we hid a lobotomized LLM on Hugging Face to spread fake news: https://blog.mithrilsecurity.io/poisongpt-how-we-hid-a-lobotomized-llm-on-hugging-face-to-spread-fake-news/
5. Inject My PDF: Prompt Injection for your Resume: https://kai-greshake.de/posts/inject-my-pdf/
6. Backdoor Attacks on Language Models: https://towardsdatascience.com/backdoor-attacks-on-language-models-can-we-trust-our-models-weights-73108f9dcb1f
7. Poisoning Language Models During Instruction: https://arxiv.org/abs/2305.00944
8. FedMLSecurity: https://arxiv.org/abs/2306.04959
9. The poisoning of ChatGPT: https://softwarecrisis.dev/letters/the-poisoning-of-chatgpt/




