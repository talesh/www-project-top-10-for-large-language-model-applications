LLM01: Kehoteinjektiot


Kehoteinjektiohaavoittuvuus ilmenee kun hyökkääjä manipuloi suurta kielimallia hienovireisten syötteiden avulla, joka saa suuren kielimallin suorittamaan hyökkääjän aikeet tiedostamattomaan. Tämä on mahdollista jailbreakingin eli järjestelmätason kehotteen (system prompt) suojauksen murtamisen avulla. Toinen tapa on epäsuora ulkoisten syötteiden manipulointi. Hyökkäys voi johtaa tiedon varastamiseen, social engineering-hyökkäyksiin ja muihin ongelmiin.


* Suora kehoteinjektio eli jailbreaking ilmenee, kun pahantahtoinen käyttäjä ylikirjoittaa tai paljastaa taustalla olevan systeemitason kehotteen (system prompt). Tämä mahdollistaa hyökkääjille suuren kielimallin kautta tapahtuvan palvelinpään järjestelmien hyväksikäytön ei-turvallisten funktioiden ja tietovarantojen avulla.


* Epäsuora kehoteinjektio ilmenee, kun suuri kielimalli hyväksyy syötteitä hyökkääjän manipuloitavissa olevista ulkoisesta lähteistä. Näitä voivat olla mm. web-sivut ja tiedostot. Hyökkääjä voi upottaa ulkoiseen sisältöön kehoteinjektion, joka kaappaa mallin kanssa käytävän keskustelun kontekstin. Tämä johtaa confused deputy-tilanteeseen, jossa hyökkäjä voi käyttää ns. hämmentynyttä mallia hyväkseen. Hyväksikäyttömahdollisuuksia ovat käyttäjän tai mallin saatavilla olevien järjestelmien manipulointi. Epäsuorien kehoteinjektioiden ei tarvitse olla ihmisen nähtävissä/luettavissa, kunhan malli parsii tekstin.


Onnistuneen kehoteinjektiohyökkäyksen tulokset voivat vaihdella suuresti pääsystä. Asteikolla ääripäissä ovat arkaluontoiseen tietoon pääsy ja kriittiseen päätöksentekoprosessiin vaikuttaminen normaaliksi toiminnaksi naamioituneena.


Kehittyneissä hyökkäyksissä suurta kielimallia voidaan manipuloida jäljittelemään vahingollista henkilöä tai olemaan vuorovaikutuksessa käyttäjän liitännäisiin. Tämä voi johtaa arkaluontoisen tiedon vuotamiseen, valtuuttamattomaan liitännäisen käyttöön tai social engineering-hyökkäykseen. Näissä tapauksissa altistunut malli auttaa hyökkääjää ohittamaan oletussuojaukset, jolloin käyttäjä ei ole tietoinen hyökkäyksestä. Malli toimii täten hyökkääjän agenttina, auttaen tämän tavoitteiden edistämistä oletussuojausten tai käyttäjän huomaamatta.


Yleisiä esimerkkejä haavoittuvuudesta


1. Pahantahtoinen käyttäjä kehittää suurelle kielimallille suoran kehoteinjektion, joka ohjeistaa mallia jättämään systeemitason kehotteen huomioimatta. Sen sijaan mallia ohjeistetaan suorittamaan kehote joka palauttaa yksityistä, vaarallista tai ei-toivottua tietoa.
2. Käyttäjän pyytää suurta kielimallia tiivistämään web-sivun sisällön. Web-sivu sisältää epäsuoran kehoteinjektion, joka saa mallin viemään käyttäjältä arkaluonteista tietoa. Tieto vuodetaan JavaScriptin tai Markdownin kautta.
3. Pahantahtoinen käyttäjä lataa jonnekin ansioluottelon, joka sisältää epäsuoran kehoteinjektion. Injektio ohjeistaa suuren kielimallin kautta käyttäjiä pitämään asiakirjaa erinomaisena ja siinä kuvattua henkilönä loistavana ehdokkaana työpaikkaan. Sisäinen käyttäjä pyytää mallia tiivistämään asiakirjan sisällön, jolloin malli kertoo että asiakirja on erinomainen.
4. Käyttäjä ottaa käyttöön verkkokauppasivustoon liittyvän liitännäisen. Käyttäjän vierailemalla sivustolla oleva pahantahtoinen ohje hyödyntää tätä liitännäistä, joka johtaa valtuuttamattomiin ostoihin.
5. Vierailtavalla sivustolla oleva pahantahtoinen ohje ja sisältö hyväksikäyttää muita liitännäisiä käyttäjien huijaamiseen.


Estäminen


Kehoteinjektiohaavoittuvuudet ovat mahdollisia suurten kielimallien luonteen takia. Ne eivät segregoi niille annettuja ohjeita ja ulkoista dataa toisistaan. Koska mallit ovat luonteeltaan luonnollisia kielimalleja, ne pitävät kumpaakin käyttäjän syötteenä. Tämän seurauksena malleissa ei ole idioottivarmaa tapaa injektioiden estämiseksi, mutta seuraavia keinoja voidaan käyttää vaikutuksen vähentämiseksi:


1. Pakota käyttöoikeuksien hallinta suuren kielimallin pääsylle palvelinpään järjestelmiin. Anna mallin käyttöön omat API-avaimet laajennetun toiminnallisuuden kuten liitännäisten, tietoihin pääsyn ja funktiotason luvituksen käyttöön. Käytä minimioikeuksien periaatetta rajoittamalla mallin pääsy minimiin sen tarvitsemia operaatioita varten.
2. Lisää ihminen laajennetun toiminnallisuuden piiriin. Suoritettaessa etuoikeutettuja operaatioita, kuten sähköpostien lähettämistä tai poistamista, laita ohjelmisto vaatimaan käyttäjän hyväksyntä operaatiolle ensin. Tämä pienentää mahdollisuutta epäsuoran komentoinjektion suorittamaan operaatioon ilman käyttäjän lupaa tai tietämystä. 
3. Erota ulkoinen sisältö käyttäjän kehotteista. Erottele ja merkitse missä epäluotettavaa sisältöä käytetään, jotta niiden vaikutusta käyttäjän kehotteisiin voidaan rajoittaa. Esimerkiksi käytä ChatML:ää OpenAI API-kutsuihin indikoimaan suurelle kielimallille kehotesyötteen lähdettä.
4. Luo luottamusrajat suuren kielimallin, ulkoisten lähteiden ja laajennettavan toiminnallisuuden välille (esim. liitännäisille tai downstream-funktioille). Kohtele mallia epäluotettavana käyttäjänä ja pidä lopullinen prosessien päätöksentekovalta käyttäjällä. Vaarantunut malli voi silti välittäjänä (man-in-the-middle) ohjelmistosi rajapinnan ja käyttäjän välillä. Malli voi tällöin piilottaa tai manipuloida informaatiota ennen sen esittämistä käyttäjälle. Näytä mahdollisesti epäluotettavat vastaukset käyttäjälle korostettuina.


Esimerkkejä hyökkäysskenaarioista


1. Hyökkääjä käyttää suoraa kehoteinjektiota suureen kielimalliin pohjautuvaa chatbottia vastaan. Injektio sisältää ohjeen “unohda kaikki aiemmat ohjeet” sekä uudet ohjeet yksityisten tietovarantojen kyselemiseksi, paketeissa olevien haavoittuvuuksien hyväksikäyttämiseksi ja palvelinpään vastevalidaation puutteen avulla lähettävin sähköposteihin. Tämä johtaa etäajohyökkäykseen, luvattomaan pääsyyn ja käyttöoikeuksien tason nostamiseen.
2. Hyökkääjä upottaa web-sivuun epäsuoran kehoteinjektion, jossa kehotetaan suurta kielimallia hylkäämään aiemmat ohjeet ja käyttäjään LLM-liitännäistä poistamaan käyttäjän sähköpostit. Kun käyttäjä pyytää mallia tiivistämään web-sivun sisällön, liitännäinen poistaa käyttäjän sähköpostit.
3. Käyttäjä pyytää suurta kielimallia tiivistämään web-sivun sisällön. Sivu sisältää epäsuoran kehoteinjektion, jossa kehotetaan mallia unohtamaan edelliset käyttäjän antamat ohjeet. Tämä saa mallin pyytämään käyttäjältä arkaluonteista tietoa, jonka se varastaa upotetun Markdown- tai JavaScript-koodin avulla.
4. Pahantahtoinen käyttäjä lataa ansioluettelon kehoteinjektion avulla. Palvelinpään käyttäjä käyttää LLM-mallia ansioluettelon tiivistämiseen ja kysyy onko henkilö sopiva kandidaatti. Kehoteinjektion takia malli sanoo kyllä, riippumatta ansioluettelon sisällöstä.
5. Käyttäjä ottaa käyttöön verkkokauppasivustoon linkitetyn liitännäisen. Vieraillulle sivustolle upotettu hyökkäävä ohje hyväksikäyttää liitännäistä luvattomien ostosten tekoon.


Linkkejä
1. ChatGPT Plugin Vulnerabilities - Chat with Code: https://embracethered.com/blog/posts/2023/chatgpt-plugin-vulns-chat-with-code/
2. ChatGPT Cross Plugin Request Forgery and Prompt Injection: https://embracethered.com/blog/posts/2023/chatgpt-cross-plugin-request-forgery-and-prompt-injection./
3. Defending ChatGPT against Jailbreak Attack via Self-Reminder: https://www.researchsquare.com/article/rs-2873090/v1
4. Prompt Injection attack against LLM-integrated Applications: https://arxiv.org/abs/2306.05499
5. Inject My PDF: Prompt Injection for your Resume: https://kai-greshake.de/posts/inject-my-pdf/
6. ChatML for OpenAI API Calls: https://github.com/openai/openai-python/blob/main/chatml.md
7. Not what you’ve signed up for- Compromising Real-World LLM-Integrated Applications with Indirect Prompt Injection: https://arxiv.org/pdf/2302.12173.pdf
8. Threat Modeling LLM Applications: http://aivillage.org/large%20language%20models/threat-modeling-llm/
9. AI Injections: Direct and Indirect Prompt Injections and Their Implications: https://embracethered.com/blog/posts/2023/ai-injections-direct-and-indirect-prompt-injection-basics/




