# Větrací mřížka s žaluzií ovládanou táhlem zespodu

Plastová větrací mřížka **180 × 250 mm** s nastavitelnou žaluzií, podobná
typu *Dalap GP 180×250 s mechanicky ovládanou žaluzií*. Rozdíl je v ovládání:
místo páčky na mřížce **visí ze spodku rámu otočná tyč s kličkou** (jako
u střešních oken), takže mřížku ve výšce ovládne i menší člověk ze země.
Tyč je při pohledu zepředu **vlevo**. Na pravou stranu ji přepne parametr
`ovladani = "vpravo"`.

- **točením kličky** se lamely plynule otevírají a zavírají, z úplně
  zavřeno do úplně otevřeno je to asi **8,5 otáčky**
- tyč se jen otáčí, nahoru ani dolů se nehýbe, klička zůstává pořád ve
  stejné výšce
- šroub je **samosvorný**: lamely drží v jakékoli poloze a nic je
  nestáhne dolů
- v krajních polohách klička **cvaká naprázdno** (prokluzovací spojka),
  takže se mechanismus nedá přetáhnout
- vzadu je **pevný rošt** a za ním **síťka proti hmyzu**, kupovaná nebo tištěná
- mřížka má dvě části: **montážní deska** zůstává na zdi, **přední kryt**
  s lamelami se sundá po pootočení 4 tištěných zámků, třeba kvůli výměně síťky

Model je parametrický (OpenSCAD) a všechny díly se tisknou **bez podpěr**.

| Otevřeno | Zavřeno | Mechanismus (boční řez) |
|---|---|---|
| ![otevřeno](obrazky/sestava_otevreno.png) | ![zavřeno](obrazky/sestava_zavreno.png) | ![animace](obrazky/mechanismus.gif) |

## Jak to funguje

![mechanismus zezadu](obrazky/mechanismus.png)

1. Deset vodorovných lamel se otáčí na čepech v rámu.
2. Na konci u táhla má každá lamela **rameno s čepem**. Rameno je schované
   v boční komoře rámu, zepředu ho není vidět.
3. V komoře jezdí svislá **ovládací lišta** (oranžová). Má deset
   vodorovných drážek otevřených dozadu, v každé klouže čep jedné lamely.
4. Lišta se pohybuje jen nahoru a dolů, **zdvih je 8,5 mm**. Lamely se
   přitom otočí o 82° z vodorovné polohy do téměř svislé a zavřené lamely
   se překrývají.
5. Ve spodním bloku lišty je **matice M6**. Prochází jí krátký kus
   **závitové tyče M6**, který vede dnem rámu ven. Tyč se v rámu jen
   otáčí: nad dnem i pod ním ji drží matice s podložkou. Když se tyč
   otočí, lišta se posune nahoru nebo dolů, **jedna otáčka = 1 mm**.
6. Pod dnem je na krátkém kusu **spojovací matice** a do ní se zespodu
   našroubuje dlouhá závitová tyč s **kličkou**. Dlouhá tyč se dá
   odšroubovat, třeba když se sundává přední kryt.
7. Závit M6 je samosvorný, takže lamely drží v každé poloze bez jakékoli
   západky a vlastní váha tyče na lištu vůbec nepůsobí.
8. Krajní polohy mají pevné dorazy v rámu: dole dosedne spodní blok lišty
   na dva výstupky v komoře, nahoře narazí lišta na doraz. Aby šroub
   dorazy nepřetížil, drží klička matice na konci tyče jen pružnými prsty.
   Když se klička točí dál, prsty přeskočí a klička cvaká naprázdno.

Rozložená sestava:

![rozloženo](obrazky/rozlozeno.png)

## Rozměry (výchozí nastavení)

| | |
|---|---|
| vnější rozměr rámu | 180 × 250 mm |
| vystoupení ze zdi | 40 mm (přední kryt 32 + montážní deska 8) |
| světlý průduch (lamely) | 140 × 206 mm |
| otvor ve zdi (zadaný) | 158 × 208 mm |
| límec do otvoru ve zdi | 156 × 206 mm (vůle 1 mm na stranu), **stěny 2 mm**, hloubka 30 mm |
| rošt v montážní desce | 152 × 202 mm, oka cca 22 × 22 mm, žebra 1,6 mm |
| síťka proti hmyzu | přes celý otvor v límci, ustřihnout na **159 × 211 mm** |
| lamely | 10 ks, rozteč 20 mm, šířka 25 mm |
| zdvih lišty | 8,5 mm = asi 8,5 otáčky kličky |
| osa závitové tyče | vlevo, 10 mm od levého okraje a 30 mm od zdi |
| vruty do zdi | 4× Fischer DuoPower 8 × 65 S jen skrz montážní desku, rozteč 100 mm vodorovně a 234 mm svisle, osa 8 mm od horní/dolní hrany (13 mm od otvoru ve zdi) |
| přední kryt k montážní desce | 4 otočné zámky na čtvrt otáčky: šroubovitý náběh, půlkruhová aretace, dorazy; rozteč 50 mm |

> **Otvor ve zdi** je nastavený na 158 × 208 mm (`otvor_sirka`,
> `otvor_vyska`). Límec se podle něj spočítá sám, o 1 mm na každou stranu
> menší (`limec_vule`).

## Díly k tisku

Hotová STL jsou ve složce [`stl/`](stl). Jsou už natočená do tiskové polohy.

| Díl | Soubor | Ks | Poznámka k tisku |
|---|---|---|---|
| Přední kryt (rám) | `ram.stl` | 1 | lícem dolů, potřebuje podložku aspoň **180 × 250 mm** |
| Montážní deska s límcem a roštem | `zadni_deska.stl` | 1 | deskou dolů; pro kupovanou síťku |
| *nebo* montážní deska s tištěnou síťkou | `zadni_deska_se_sitkou.stl` | 1 | místo předchozí; deskou dolů, viz [Síťka proti hmyzu](#síťka-proti-hmyzu) |
| Lamela | `lamela.stl` | **10** | rovnou stranou dolů, rameno nahoru |
| Ovládací lišta | `lista.stl` | 1 | naležato drážkami nahoru, délka 208 mm |
| Pojistný hřebínek u táhla | `pojistka_u_tahla.stl` | 1 | naležato |
| Pojistný hřebínek protější (se žebry) | `pojistka_protejsi.stl` | 1 | naležato, žebry nahoru |
| Klička s prokluzovací spojkou | `klika.stl` | 1 | dnem dolů, prsty a knoflík nahoru |
| Vodítko tyče na zeď | `voditko.stl` | 0–2 | volitelné, když se tyč při točení moc houpe |
| Otočný klíč zámku | `klic.stl` | **4** | nastojato na rovné straně příčky, hlavou nahoru, bez podpěr; 4 perimetry, výplň 100 % |

**Materiál:** PETG (do interiéru) nebo ASA (na přímé slunce, originál je
také z ASA). PLA nedoporučuji, protože pružné díly (prsty kličky, hřebínky)
z PLA časem povolí nebo prasknou.
**Nastavení:** vrstva 0,2 mm, 3 perimetry, výplň 20 %, **bez podpěr**.
Lištu a kličku tiskněte se 4 perimetry.

## Co koupit

| Položka | Ks | Kde koupit (příklady) |
|---|---|---|
| Hmoždinka **Fischer DuoPower 8 × 65 S** (balení obsahuje zápustné vruty **5 × 80**) | 4 | [KUTIL.cz](https://www.kutil.cz/spojovaci-material-a-kotevni-technika/kotevni-technika/vseobecne-hmozdinky/hmozdinka-duopower-fischer-8x65-1/), [srovnání cen na Heureka](https://www.heureka.cz/?h%5Bfraze%5D=hmo%C5%BEdinka+duopower+fischer+8x65), [technický list Fischer](https://www.fischer-cz.cz/cs-cz/products/bezne-hmozdinky/plastove-hmozdinky/duopower/538256-duopower-8x65-s) |
| **Závitová tyč M6 × 1 m**, DIN 975 (pozink nebo nerez); z ní se uřízne krátký kus 38 mm do rámu a zbytek je táhlo ke kličce | 1 (2, pokud má být táhlo delší než 95 cm) | [KUTIL.cz – závitové tyče Zn DIN 975](https://www.kutil.cz/spojovaci-material-a-kotevni-technika/srouby/zavitove-tyce/zavitova-tyc-zn-1m-din-975/), [KUTIL.cz – nerez A2 M6](https://www.kutil.cz/spojovaci-material-a-kotevni-technika/srouby/zavitove-tyce/zavitova-tyc-nerez-a2-1m-din-975-m6/), [Zboží.cz – M6 1 m](https://www.zbozi.cz/vyrobek/zavitova-tyc-m6-1m-din975-tp-4-8/) |
| **Matice M6**, DIN 934 (1 do lišty, 2 do kličky, 1 kontramatice pod spojovací maticí) | 4 | [NonstopStavebniny – DIN 934 M6](https://www.nonstopstavebniny.cz/sestihranna-matice-din-934--m6-pozink/), [Prumex – DIN 934 M6](http://www.spojovaci-material.net/sp/matice/sestihranne/presne-din-934/ocel-tridy-8/pozink/matice-din-934-m6-08-pozink-6755.html) |
| **Samojistná matice M6**, DIN 985 (1 nad dno rámu, 1 pod kličku) | 2 | [Prumex – DIN 985 M6](https://www.prumex.cz/matice-samojistna-din-985-m6-08-pozink/), [ProPrumysl – DIN 985 M6](https://www.proprumysl.cz/matice-samojistna-din-985-m6-08-pozink/) |
| **Podložka M6**, DIN 125 (nad dno a pod dno rámu) | 2 | [Wintech – DIN 125 M6](https://www.wintech.cz/podlozka-din-125-a-m6-6-4-zb_z9212/), [Provleky – DIN 125 M6](https://www.provleky.cz/katalog/podlozky-pod-skrutky-a-matice/produkt/podlozka-m6--6-4--zb-din-125-a) |
| **Spojovací (prodlužovací) matice M6 × 18**, DIN 6334 (pod dnem rámu; druhá, pokud se spojují dvě dlouhé tyče) | 1 (2) | [Wintech – DIN 6334 M6 × 18](https://www.wintech.cz/matice-prodluzovaci-din-6334-m6-x-18-zb_z6259/), [Atlas – DIN 6334 M6](https://www.atlashop.cz/matice-prodluzovaci-sestihranna-din-6334-m6), [BOUKAL – DIN 6334 M6](https://www.boukal.cz/spojovaci-matice-m6-format-7439080010-din-6334/55965/produkt) |
| Síť proti hmyzu, sklolaminátová, metráž (stačí kus 16 × 22 cm) | 1 | [UNI HOBBY – metráž šedá](https://unihobby.cz/sit-proti-hmyzu-sklovlaknita-metraz-seda), [BAUHAUS – sítě proti hmyzu](https://www.bauhaus.cz/site-proti-hmyzu-245270), [OBI – sítě proti hmyzu](https://www.obi.cz/ochrana-proti-hmyzu/ochranne-site-proti-hmyzu/c/2200), [Onpira – metráž](https://www.onpira.cz/zbozi/site-proti-hmyzu-skelne-vlakno/) |
| Vodítko (volitelné): 2 vruty 3,5 × 30 mm a hmoždinky 5 mm | 2 | [Heureka – hmoždinka 5 mm s vrutem](https://www.heureka.cz/?h%5Bfraze%5D=hmo%C5%BEdinka+5+mm+s+vrutem) |

Z nářadí stačí pilka na kov (zkrácení tyče) a klíč 10 mm.

### Délka závitové tyče

- **Krátký kus v rámu: 38 mm** (35–41 mm stačí). Konce zabruste, aby šly
  matice snadno našroubovat.
- **Dlouhá tyč ke kličce:**

```
délka ≈ (výška spodní hrany mřížky) − (výška, kde má být klička) − 5 mm
```

Příklad: mřížka má spodek ve 240 cm a klička má být ve 150 cm, tedy tyč
asi 89,5 cm. Klička se nahoru ani dolů nehýbe. Na delší tyč spojte dva
kusy druhou spojovací maticí a zajistěte je kontramaticemi.

## Sestavení předního krytu

1. **Očistěte díly.** Lamela se musí v drážkách „U“ rámu otáčet volně. Když
   drhne, přejeďte čepy smirkem. Čepy na ramenech musí volně klouzat
   v drážkách lišty.
2. Rám položte **lícem dolů** na stůl. Komora mechanismu je teď při pohledu
   zezadu **vpravo**.
3. **Připravte lištu:** do šestihranného lůžka ve spodním bloku lišty
   zasuňte zezadu **matici M6**. Lištu vložte do komory drážkami k lamelám
   a spodním blokem dolů (ke dnu rámu). Lišta se zatím volně posouvá.
4. **Vkládejte lamely** jednu po druhé, zezadu, ramenem do komory. Každou
   natočte tak, aby čep na rameni byl proti drážce v liště, a spusťte ji
   dolů. Osa zapadne do drážky „U“ a **čep stejným pohybem vjede do drážky
   lišty** (drážky mají na konci rozšířený náběh). První lamela nastaví
   lištu, další vkládejte pod stejným úhlem.
5. **Zatlačte oba pojistné hřebínky** do vybrání na horní hraně přepážek,
   až **cvaknou**. Jejich prsty zajistí čepy lamel v drážkách. Každý prst je
   rozdělený na dvě pružné poloviny s výstupky, které zapadnou do drážek ve
   stěnách krytu, takže hřebínek drží i v sundaném krytu. Vytáhnout se dá
   silou (výstupky mají šikmé boky). Sílu západky mění `hrebinek_zapadka`.

   Hřebínky jsou dva různé díly. `pojistka_u_tahla` patří na přepážku vedle
   mechanismu (při táhle vlevo je to levý). `pojistka_protejsi` patří na
   volně stojící stěnu průduchu na druhé straně (při táhle vlevo pravý).
   Ten má navíc žebra, která vyplní mezeru mezi stěnou průduchu a vnější
   stěnou krytu a opřou se o ni. Hřebínek se tak nemůže naklonit ani
   posunout do strany a výstupky prstů nevyskočí z drážek. Žebra jsou mezi
   prsty, takže prsty dál pruží.

   ![detail západky hřebínku](obrazky/hrebinek_detail.png)

   *Hřebínek (modrý) vytažený z krytu: každý prst je rozdělený na dvě pružné
   poloviny s výstupky, ve stěnách drážek „U“ v krytu jsou proti nim drážky.*
6. **Vyzkoušejte chod:** prstem posuňte lištu nahoru a dolů. Lamely se musí
   otáčet všechny současně a lehce.
7. **Krátký kus závitové tyče (38 mm):** na horní konec našroubujte
   **samojistnou matici tak, aby nad ní zbylo 17 mm tyče**, a pod ni
   nasaďte podložku. Lištu posuňte nahoru, tyč prostrčte zevnitř komory
   dnem rámu ven a dosedněte maticí s podložkou na dno. Zespodu nasaďte
   druhou podložku a našroubujte **spojovací matici**, až se dotkne
   podložky, pak ji povolte o čtvrt otáčky (tyč se musí volně otáčet, ale
   nesmí mít vůli nahoru a dolů). Točením spojovací matice zašroubujte tyč
   do matice v liště. Lamely se musí otáčet.
8. **Klíče zámků** (bez lepidla a bez šroubů) se zasouvají až při nasazení
   krytu na montážní desku, viz [Montáž na zeď](#montáž-na-zeď-fischer-duopower-8--65-s),
   krok 6.

## Zámek krytu (jak funguje)

![řez zámkem v zamčené poloze](obrazky/zamek_rez.png)

*Řez osou zámku: vlevo zápustná hlava klíče v líci krytu, kulatý dřík skrz kryt,
vpravo půlkulatá příčka za plným dnem zámku v montážní desce, úplně vpravo zeď.*

![otáčení klíče](obrazky/zamek_otaceni.png)

*Nahoře zepředu: hlavy klíčů (Ø 17 mm) jsou zapuštěné a zarovnané s lícem
krytu a otáčejí se v kuželovém lůžku; zářez svisle = zamčeno, vodorovně =
odemčeno. Vpravo klíč v tiskové poloze. Dole pohled od zdi do montážní
desky: příčka se otáčí v kulaté kapse montážní desky za krytem, v krytu je jen
kulatý dřík. Vodorovnou štěrbinu v krytu hlava zakryje v každé poloze.*

Zámek je udělaný jako současné vačkové zámky na čtvrt otáčky (např. u
rozvaděčů): příčka po **šroubovitém náběhu** postupně přitáhne kryt, na konci
zapadne do **aretace** a **doraz** nedovolí přetočení. Všechny tvary, které
se o sebe opírají, jsou **zaoblené (půlkulaté)**: nemají ostré hrany, které
by soustředily napětí a vyrývaly se do plastu.

- **Klíč:** zápustná kulatá hlava Ø 17 mm se zkosením 45° sedí v kuželovém
  lůžku v líci krytu, zarovnaná s lícem, a sama se vystředí. Kulatý dřík
  Ø 8 mm a **půlkulatá příčka** (Ø 8 mm, rovnou stranou ke zdi, zaoblené
  konce). Tiskne se nastojato na rovné straně příčky, hlavou nahoru, bez
  podpěr. Průřez dříku Ø 8 mm unese v tahu i napříč vrstvami řádově přes
  1000 N, zámek přitom nese jen desítky N.
- **Náběh:** za vodorovnou štěrbinou v montážní desce je plné dno 2,4 mm,
  pevně spojené se zbytkem desky a tištěné celou plochou na podložce, a na
  něm šroubovitý náběh. Příčka se točí v kulaté kapse, okolo je deska plná
  až k okraji. Příčka po náběhu najíždí a kryt se přitáhne.
- **Aretace:** v zamčené poloze příčka zapadne do půlkruhového lůžka
  vytvarovaného přesně podle ní a zámek **cvakne**. Přesah 0,3 mm drží
  kryt přitažený. Aby se zámek povolil, musí příčka vyjet zpátky přes
  hranu aretace (0,35 mm), takže se sám neotevře.
- **Dorazy:** klíč se točí jen jedním směrem a jen o čtvrt otáčky. Dorazy
  jsou plné bloky přes celou hloubku kapsy (až po zadní plochu desky),
  srostlé s její stěnou a s rovným čelem, takže se přes ně oblá příčka
  nepřetlačí.
- **Stejný směr zasunutí:** štěrbina v krytu i v montážní desce je
  vodorovná, klíč se zasune skrz oba díly najednou.
- **Obvodová polodrážka (lip and groove):** zadní hrana stěn krytu má po
  celém obvodu límeček 1,4 × 1,8 mm se zúženou špičkou a v čele montážní
  desky je pro něj drážka s vůlí 0,2 mm. Kryt se na desce vystředí ve
  všech směrech dřív, než se zasunou klíče, takže štěrbiny v obou dílech
  jsou přesně proti sobě. Spára mezi díly je navíc zakrytá.
- **Ovládání:** mincí nebo plochým šroubovákem; zářez **svisle = zamčeno**,
  **vodorovně = odemčeno**.

Zámek je tuhý (nic v něm nepruží), proto rozhoduje přesnost tisku. Nejdřív
vytiskněte jeden klíč a kousek desky se zámkem. Když jde zámek moc ztuha,
zmenšete `klic_predpeti` (např. 0,15) a `aretace_hl` (např. 0,2); když kryt
drží volně, `klic_predpeti` zvětšete.

## Montáž na zeď (Fischer DuoPower 8 × 65 S)

![detail uchycení](obrazky/detail_uchyceni.png)

Na zeď se přišroubuje jen **montážní deska** (8 mm). Zápustné hlavy vrutů
5 × 80 jsou v rovině jejího čela, takže je přední kryt zcela zakryje. Vrut
jde do hmoždinky 72 mm (Fischer předepisuje aspoň 70 mm).

1. Montážní desku zasuňte límcem do otvoru ve zdi a srovnejte do vodováhy.
   Skrz 4 otvory označte místa pro hmoždinky a desku sundejte.
2. Vyvrtejte díry **Ø 8 mm, hloubka aspoň 85 mm**. Do cihly a porobetonu
   vrtejte bez příklepu. Vyfoukejte prach.
3. Hmoždinky zatlučte **do roviny zdi**.
4. Montážní desku přišroubujte vruty 5 × 80. Hlavy musí zapadnout do
   zahloubení v rovině čela desky.
5. **Síťka:** kupovanou síťku 159 × 211 mm nabodněte na 4 malé trny na zadní
   straně předního krytu (u horního a dolního okraje průduchu). Trny ji
   drží, takže při nasazování nespadne. (U montážní desky s tištěnou síťkou
   tento krok odpadá.)
6. **Nasaďte přední kryt** na montážní desku tak, aby límeček na zadní
   hraně krytu zapadl po celém obvodu do drážky v desce. Pak do každého otvoru v líci krytu zasuňte klíč
   se zářezem **vodorovně** (příčka projde vodorovnou štěrbinou v krytu
   i v desce, hlava zapadne do zápustného lůžka). Klíč přitlačte a otočte
   mincí nebo šroubovákem o **čtvrt otáčky**, až je zářez **svisle**
   a zámek cvakne.
7. **Klička:** na spodní konec dlouhé tyče našroubujte **2 matice M6**
   a pevně je stáhněte proti sobě, aby jejich spodek byl **26,5 mm od konce
   tyče**. Kličku nasuňte zespodu prsty přes matice (jdou ztuha, prsty se
   roztáhnou): matice musí sedět nahoře u konců prstů, jinak by byly prsty
   moc tuhé. Kličku zajistěte zespodu **samojistnou maticí**, s malou vůlí,
   aby se klička dala pootočit, když prsty přeskočí.
8. **Táhlo:** na horní konec dlouhé tyče našroubujte kontramatici, tyč
   zašroubujte zespodu do spojovací matice až na doraz o krátký kus a
   kontramatici utáhněte proti spojovací matici.
9. Pokud se tyč při točení houpe, přišroubujte doprostřed její délky
   **vodítko**. Tyč se do něj dá zacvaknout i dodatečně.

> ⚠️ **Vzdálenost od okraje otvoru ve zdi.** Otvor 208 mm je vysoký, nad ním
> i pod ním zbývá v mřížce 250 mm jen 21 mm. Vruty jsou proto co nejblíž
> vnější hraně desky (osa 8 mm od hrany, dál to nejde kvůli hlavě vrutu):
> osa hmoždinky je 13 mm od otvoru a mezi vývrtem Ø 8 a otvorem zbývá
> **asi 9 mm zdiva**. Vrtejte bez příklepu a vruty utahujte citlivě.
> Minimální vzdálenost od okraje pro váš materiál uvádí technický list
> Fischer. Víc místa dá jen vyšší mřížka (`vyska`), ta se ale nad 250 mm
> nevejde na běžné tiskové podložky. Model při změně parametrů vypíše,
> kolik zdiva zbývá.

## Síťka proti hmyzu

![výměna síťky: montážní deska na zdi, přední kryt sundaný](obrazky/vymena_sitky.png)

| Zezadu | Rozloženo (tištěná síťka) |
|---|---|
| ![zezadu](obrazky/zezadu_sitka.png) | ![rozloženo se síťkou](obrazky/rozlozeno_sitka.png) |

Síťka je **uprostřed mřížky, sevřená mezi předním krytem a montážní
deskou**. Drží ji po celém obvodu 4 otočné klíče, takže nemůže vypadnout ani
se po okraji vysunout. Hned za ní je **pevný rošt** v montážní desce, který
ji podepře a nepustí dovnitř ptáky. Před ní je 1,5 mm volného místa
k lamelám.

**Výměna nebo vyčištění síťky:** mincí otočte 4 klíče zářezem vodorovně,
vytáhněte je, odšroubujte dlouhou tyč ze spojovací matice (povolte
kontramatici) a přední kryt sundejte. Montážní deska zůstane na zdi a síťka je
hned přístupná.

**Kupovaná síťka:** ze sklolaminátové sítě proti hmyzu ustřihněte obdélník
**159 × 211 mm** (pokryje celý otvor v límci). Přední kryt má pro síťku lůžko hluboké 0,25 mm, takže ji
montážní deska pevně stiskne.

**Tištěná síťka:** vytiskněte `zadni_deska_se_sitkou.stl` místo
`zadni_deska.stl`. Síťka je plochá mřížka v prvních dvou vrstvách montážní
desky: vlákna v obou směrech leží celou plochou na podložce, nic nevisí ve
vzduchu. Oka 1,2 × 1,2 mm, tloušťka 0,4 mm (dva průjezdy po 0,2 mm, lze
zvětšit parametrem `tistena_tl`). Tiskne se deskou dolů na čistou
podložku, výška vrstvy **0,2 mm**, šířka extruze 0,45–0,5 mm, bez
„ironing“. Pokud slicer vlákna vynechá, zvětšete `tistena_vlakno` na 0,6.
Rozteč lze změnit parametrem `tistena_roztec`.

Rošt ubere asi 12 % průřezu, síťka proti hmyzu dalších zhruba 30–40 %.
S tím je potřeba počítat, pokud je větrání na hraně.

## Úpravy modelu

Otevřete `mrizka.scad` v [OpenSCAD](https://openscad.org) (2021.01 nebo
novější). V panelu *Customizer* lze měnit hlavně:

- `ovladani`: strana táhla při pohledu zepředu (`vlevo` nebo `vpravo`)
- `sirka`, `vyska`: vnější rozměr rámu
- `pocet_lamel`, `roztec`, `sirka_lamely`: počet a velikost lamel.
  Světlý průduch a okraje se dopočítají samy.
- `otvor_sirka`, `otvor_vyska`: světlý otvor ve zdi; límec se spočítá sám
  (`limec_vule`), nebo ho zadejte ručně (`limec_sirka`, `limec_vyska`)
- `vrut_od_okraje`: vzdálenost vrutu od hrany desky (menší = dál od otvoru)
- `tl_desky`, `roztec_sroubu`, `hlava_sroubu`: montážní deska a vruty do
  zdi (výchozí hodnoty pro Fischer DuoPower 8 × 65 S s vrutem 5 × 80)
- `roztec_klicu`, `klic_predpeti`, `aretace_hl`, `dno_zamku`: zámky předního krytu
  (viz [Zámek krytu](#zámek-krytu-jak-funguje))
- `bok_protejsi`: šířka bočního okraje bez mechanismu (výchozí 20 mm = souměrný kryt)
- `hrebinek_zapadka`: výška výstupků západky pojistných hřebínků
- `sitka`: `kupovana`, `tistena` nebo `zadna`; `sitka_tl`: hloubka lůžka
  pro kupovanou síťku; `rost_roztec`, `rost_zebro`: pevný rošt;
  `tistena_roztec`, `tistena_vlakno`: tištěná síťka
- `klika_r`: poloměr kličky
- `spojka_prst`: tloušťka pružných prstů v kličce (tlustší = prokluzuje až
  při větší síle)
- `dil`: co se vykreslí (sestava, řez, schéma, rozložený pohled nebo
  jednotlivé díly pro tisk)
- `otevreni`: poloha žaluzie v náhledu (0 až 1)

Model obsahuje kontroly (`assert`), které upozorní na nesmyslnou kombinaci
parametrů.

**Kontrola kolizí a přegenerování STL a obrázků:**

```bash
./skripty/export.sh                              # výchozí rozměry
./skripty/export.sh -D vyska=300 -D pocet_lamel=12   # vlastní rozměry
```

Skript nejdřív spustí `kontrola.scad`. Ta ve 41 polohách mezi zavřeno
a otevřeno ověří, že lamely nenarážejí do sebe ani do rámu, ramena nenarážejí
do komory ani do spodního bloku lišty, čepy zůstávají v drážkách lišty
a lišta nenarazí na matici na dně. Teprve potom skript
vygeneruje STL, obrázky a animaci.

## Ladění

- **Klička prokluzuje už při běžném točení:** zvětšete `spojka_prst`
  (např. 2,8). **Klička neprokluzuje ani v dorazu:** zmenšete ho (např. 2,0).
- **Lamely se točí ztuha:** zkontrolujte, že spojovací matice pod dnem
  netlačí na podložku (povolte ji o čtvrt otáčky), a přejeďte čepy
  a drážky lišty smirkem.
- **Lamely drhnou:** zvětšete vůle, tedy `r_osa + 0.2` v drážkách „U“,
  nebo zabruste čepy.
- **Zavřené lamely nedoléhají:** úhel `uhel_zavreni` lze zvednout až k mezi,
  kterou hlídá `assert` (výchozí 82° nechává mezi lamelami 0,4 mm).

## ⚠️ Důležité upozornění

Pokud mřížka přivádí **spalovací vzduch pro plynový spotřebič** (kotel,
karma, sporák v bytě s komínovým spotřebičem), **nesmí být uzavíratelná**.
Plynárenská pravidla (TPG 704 01) uzavíratelné větrací otvory pro přívod
spalovacího vzduchu nepovolují. Tuto mřížku tam nepoužívejte. Hrozí otrava
oxidem uhelnatým.

## Alternativy ovládání

Kdyby tyč překážela, dá se dlouhá tyč odšroubovat a nosit zvlášť: na
spojovací matici pod rámem stačí nasadit kličku jen při ovládání.
