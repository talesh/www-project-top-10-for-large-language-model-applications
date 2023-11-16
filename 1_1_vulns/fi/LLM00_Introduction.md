Suurien kielimalliohjelmistojen (LLM) OWASP Top 10
Versio 1.0 
Julkaistu: 1.8.2023




Suuriin kielimalleihin (LLM) liittyvä kiinnostus on ollut räjähtävän suurta. Tämä on seurausta esikoulutettujen chatbottien laajasta käyttöönotosta 2022 loppupuolella. Mallien potentiaalin valjastamisesta innostuneet yritykset ovat nopeasti integroimassa niitä operatiiviseen käyttöön ja asiakasrajapintaratkaisuihin. Mallien huima käyttöönottonopeus on kuitenkin ollut nopeampaa, kuin kattavien suojausprotokollien luonti. Tämä on johtanut useisiin korkean riskin haavoittuvuuksiin ohjelmistoissa.


Oli selvää, että näihin turvallisuushuoliin kantaa ottava yhtenäinen lähde puuttui. Mallien riskeistä tietämättömillä kehittäjillä oli vain hajanaisia resursseja. OWASPin tehtävä tuntui sopivan tämän teknologian turvallisemman käyttöönoton edistämiseen.
Kohderyhmä
Ensisijainen kohderyhmämme ovat LLM-teknologioita käyttävien ohjelmista ja liitännäisiä suunnittelevat ja kehittävät kehittäjät, datatieteilijät ja turvallisuusasiantuntijat. Tavoitteemme on tarjota käytännöllistä ja ytimekästä turvallisuusohjeistusta, joiden avulla asiantuntijat voivat toimia LLM-turvallisuuden monimutkaisessa ja kehittyvässä maailmassa.
Listan luonti
Tämän OWASP Top 10-listan luonti oli merkittävä ponnistus, johon otti osaa lähes 500 asiantuntijan kansainvälinen tiimi. Kontribuutioita teki yli 125 aktiivista jäsentä, joiden tausta vaihtelee tekoäly-yrityksistä tietoturvayrityksiin, ohjelmistojen jälleenmyyjiin, hyperscaler-pilvitoimittajiin, laitteistotoimittajiin ja akateemikkoihin.


Kuukauden kestäneen aivoriihen aikana tiiminjäsenet kirjasivat 43 eri uhkaa. Usean äänestyskierroksen jälkeen nämä uhat karsittiin kymmeneen kriittisimpään haavoittuvuuteen. Jokainen haavoittuvuus jalostettiin erillisten tiimien toimesta. Haavoittuudet altistettiin tämän jälkeen julkiselle arvostelulle, lopullisen listan kattavuuden ja käytännöllisyyden varmistamiseksi.


Myös jokaiseen haavoittuvuuteen liittyvät esimerkit, estämisvinkit, hyökkäysskenaariot ja viitteet jalostettiin erillisten tiimien ja julkisen arvostelun avulla.
Yhteydet muihin OWASP Top 10-listoihin


Vaikka tässä listassa on samoja haavoittuvuustyyppejä kuin muissa OWASP Top 10-listoissa, niitä ei ole vain listattu tässä uutelleen. Sen sijaan keskitytään uniikkeihin vaikutuksiin joita haavoittuvuuksilla on suuria kielimalleja käyttävissä ohjelmistoissa.


Tavoitteemme on muodostaa yhtenäinen kuva yleisistä ohjelmistoturvallisuuden periaatteista ja suurten kielimallien erityisistä haasteista. Tämä sisältää pohdintoja siitä, miten tyypilliset haavoittuvuudet voivat aiheuttaa mallien kanssa erilaisia riskejä. Perinteisiä remediaatiostrategioita saatetaan myös joutua mukauttamaan suuria kielimalleja käyttäviä ohjelmistoja varten.


Tulevaisuus
Listan ensimmäinen versio ei tule olemaan viimeinen. Listaa tullaan päivittämään säännöllisesti, jotta se pysyy ajan tasalla alan tilaan nähden. Tulemme työskentelemään laajemman yhteisön kanssa alan kehittämiseksi ja monikäyttöisten koulutusmateriaalien luomiseksi.
Pyrimme myös yhteistyöhön standardisointielinten ja valtioiden kanssa tekoälyturvallisuuteen liittyvissä aiheissa. Toivotamme sinut tervetulleeksi liittymään ryhmäämme ja osallistumaan.


Steve Wilson
Projektinvetäjä, Suurten kielimallien OWASP Top 10
Twitter/X: @virtualsteve


Suurien kielimalliohjelmistojen (LLM) OWASP Top 10
LLM01: Kehoteinjektio
Haavoittuvuudessa manipuloidaan suurta kielimallia hienovireisten syötteiden avulla, joka johtaa ei-toivottuihin toimintoihin suuressa kielimallissa. Suorat injektiot ylikirjoittavat systeemitason kehotteet. Epäsuorat injektiot manipuloivat ulkoisten lähteiden syötteitä.
LLM02: Turvaton vasteen käsittely
Tämä ilmenee, kun suuren kielimallin vaste hyväksytään ilman tarkistusta, joka johtaa palvelinpään järjestelmien altistumiseen. Väärinkäyttö voi johtaa vakaviin seurauksiin, kuten XSS-, CSRF-, SSRF- tai RCE-haavoittuvuuksiin tai käyttöoikeuksien laajentamiseen.


LLM03: Opetusdatan myrkyttäminen
Tämä ilmenee, kun suuren kielimallin opetusdataa peukaloidaan. Myrkyttäminen aiheuttaa haavoittuvuuksia tai vinoumia, jotka vaarantavat turvallisuuden, tehokkuuden tai eettisen käytöksen. Lähteitä ovat mm. Common Crawl, WebText, OpenWebText ja kirjallisuus.


LLM04: Malliin kohdistuva palvelunestohyökkäys
Hyökkääjät aiheuttavat suuressa kielimallissa resurssi-intensiivisiä operaatioita. Tämä johtaa palvelun tason heikkenemiseen tai kasvaneisiin kustannuksiin. Haavoittuvuuden teho suurenee suuren kielimallien resurssi-intensiivisen luonteen ja käyttäjien arvaamattomien syötteiden vuoksi.


LLM05: Toimitusketjun haavoittuvuudet
Haavoittuvat komponentit tai palvelut voivat vaarantaa suurta kielimallia käyttävän ohjelmiston elinkaaren, johtaen hyökkäyksiin. Kolmannen osapuolen tietoaineistojen, esivalmennettujen mallien ja liitännäisten käyttö voi lisätä haavoittuvuuksia.


LLM06: Arkaluonteisen tiedon paljastaminen
Suuret kielimallit voivat paljastaa luottamuksellista tietoa vastauksissaan tahattomasti. Tämä voi johtaa valtuuttamattomaan pääsyyn tietoon, yksityisyyden loukkauksiin ja tietoturvaloukkauksiin. Vaikutusten lieventämiseksi on ratkaisevan tärkeää toteuttaa tiukat tiedon sanitointi- ja käyttäjäpolitiikat.
LLM07: Liitännäisten turvattomuus
Suurten kielimallien liitännäiset voivat sisältää turvaamattomia syötteitä ja puutteellista pääsynvalvontaa. Nämä hallinnan puutteet kasvattavat niiden hyväksikäyttömahdollisuuksia, jolloin seurauksia voivat olla mm. koodin etäajohyökkäykseen (remote code execution).


LLM08: Liiallinen autonomia
Suurten kielimallien pohjalle rakennetut järjestelmät voivat suorittaa tehtäviä, joilla on tahattomia seurauksia. Ongelma johtuu tällaisten järjestelmien liiallisesta toiminnallisuudesta, luvituksesta tai autonomiasta.


LLM09: Yliluottamus
Liikaa suuriin kielimalleihin luottavat järjestelmät tai ihmiset voivat kohdata väärää tietoa tai viestintää, lakiteknisiä ongelmia ja tietoturvahaavoittuvuuksia. Nämä voivat johtua suurten kielimallien tuottamasta väärästä tai sopimattomasta sisällöstä.


LLM10: Mallin varastaminen
Tämä sisältää omistusoikeudellisen suuren kielimallin luvittamattoman pääsyn, kopioinnin tai tiedon varastamisen. Vaikutuksia ovat mm. taloudelliset menetykset, kilpailukyvyn vaarantuminen ja mahdollinen pääsy arkaluontoiseen tietoon.


