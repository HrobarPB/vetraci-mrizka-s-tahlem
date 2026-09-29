# Větrací mřížka s žaluzií ovládanou táhlem zespodu

Plastová větrací mřížka **180 × 250 mm** s nastavitelnou žaluzií, podobná
typu *Dalap GP 180×250 s mechanicky ovládanou žaluzií*. Rozdíl je v ovládání:
místo páčky na mřížce **visí ze spodku rámu otočná tištěná tyč s rukojetí**,
takže mřížku ve výšce ovládne i menší člověk ze země.
Tyč je při pohledu zepředu **vlevo**. Na pravou stranu ji přepne parametr
`ovladani = "vpravo"`.

- rukojetí se otáčí o **půl otáčky**, tři polohy jsou po čtvrtotáčkách:
  **0° zavřeno, 90° napůl, 180° otevřeno**; šipka na rukojeti ukazuje, kde
  mřížka je
- v každé poloze je **zastavovací ploška**, lamely tam drží samy a nic je
  nestáhne dolů; konce drážky jsou pevné dorazy
- tyč se jen otáčí, nahoru ani dolů se nehýbe
- všechny díly mechanismu včetně tyče se **tisknou**, nic se nekupuje
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
2. Na konci u táhla má každá lamela **vidlicové rameno** s rozšířeným ústím.
   Rameno je schované v boční komoře rámu, zepředu ho není vidět.
3. V komoře jezdí svislá **ovládací lišta** (oranžová). Její čepy zapadají
   do vidlic všech lamel najednou.
4. Lišta se pohybuje jen nahoru a dolů, **zdvih je 13 mm**. Lamely se přitom
   otočí o 82° z vodorovné polohy do téměř svislé a zavřené lamely se
   překrývají.
5. Pod lištou stojí na dně komory **rotační klín** (vačka): plný kotouč
   Ø 15 mm, stejný princip jako revolverový hloubkový doraz horní frézky.
   Nahoře má vyříznuté ploché stupně a šikmé náběhy a lišta na něm stojí
   **masivní nohou** (6 × 4 mm) s klínovou patkou. Když se kotouč otočí,
   noha vyjede po náběhu na vyšší stupeň nebo sjede na nižší.
6. Kotouč má tři vodorovné **stupně**: v poloze 0° (zavřeno), 90° (napůl)
   a 180° (otevřeno), mezi nimi jsou náběhy asi 40°. Lišta stojí na stupni
   vlastní vahou, takže v otevřené poloze stojí na nejvyšším stupni
   a nemá kam sjet. Když se rukojeť pustí mezi polohami, lišta po náběhu
   sama sjede na nejbližší nižší stupeň. Zbytek kotouče, kam noha nikdy
   nedojede, je plný a o 3 mm vyšší než nejvyšší stupeň: o něj noha za 0°
   a za 180° narazí (pevné dorazy).
7. Kotouč má dole čep, který prochází drážkou ve dně rámu, shora ho
   přitlačuje lišta. Váha tyče visí na kotouči, ne na liště.
8. Do čepu kotouče se zespodu zacvakne **tištěná tyč**: kulatá Ø 8 mm,
   jen konce jsou šestihranné (8 mm přes plošky). Tyč je složená z dílů,
   které se spojují tištěnými **spojkami**, dole je **rukojeť**
   s křidélkem na jednu stranu a šipkou.

Rozložená sestava:

![rozloženo](obrazky/rozlozeno.png)

## Rozměry (výchozí nastavení)

| | |
|---|---|
| vnější rozměr rámu | 180 × 250 mm |
| vystoupení ze zdi | 37,5 mm (přední kryt 29,5 + montážní deska 8) |
| světlý průduch (lamely) | 140 × 206 mm |
| otvor ve zdi (zadaný) | 158 × 208 mm |
| límec do otvoru ve zdi | 156 × 206 mm (vůle 1 mm na stranu), **stěny 2 mm**, hloubka 30 mm |
| rošt v montážní desce | 152 × 202 mm, oka cca 22 × 22 mm, žebra 1,6 mm |
| síťka proti hmyzu | přes celý otvor v límci, ustřihnout na **159 × 211 mm** |
| lamely | 10 ks, rozteč 20 mm, šířka 25 mm |
| zdvih lišty | 13 mm, polohy 0° / 90° / 180° |
| osa tyče | vlevo, 11 mm od levého okraje a 26,6 mm od zdi |
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
| Ovládací lišta | `lista.stl` | 1 | naležato, čepy nahoru |
| Vačka (stupňový doraz) | `vacka.stl` | 1 | nastojato, čepem dolů; 4 perimetry, výplň 100 % |
| Pojistný hřebínek u táhla | `pojistka_u_tahla.stl` | 1 | naležato |
| Pojistný hřebínek protější (se žebry) | `pojistka_protejsi.stl` | 1 | naležato, žebry nahoru |
| Díl tyče (kulatá Ø 8, šestihranné konce, 230 mm) | `tyc.stl` | podle výšky (viz níže) | naležato na plošce; 4 perimetry |
| Spojka dílů tyče | `spojka.stl` | o 1 méně než dílů tyče | nastojato |
| Rukojeť se šipkou | `rukojet.stl` | 1 | zásuvkou nahoru |
| Vodítko tyče na zeď | `voditko.stl` | 0–2 | volitelné, když se tyč při točení moc houpe |
| Otočný klíč zámku | `klic.stl` | **4** | nastojato na rovné straně příčky, hlavou nahoru, bez podpěr; 4 perimetry, výplň 100 % |

**Materiál:** PETG (do interiéru) nebo ASA (na přímé slunce, originál je
také z ASA). PLA nedoporučuji, protože pružné díly (hroty tyče, hřebínky)
z PLA časem povolí nebo prasknou.
**Nastavení:** vrstva 0,2 mm, 3 perimetry, výplň 20 %, **bez podpěr**.
Lištu tiskněte se 4 perimetry, vačku a díly tyče se 4 perimetry a 100 %
výplní (přenášejí otáčení).

## Co koupit

| Položka | Ks | Kde koupit (příklady) |
|---|---|---|
| Hmoždinka **Fischer DuoPower 8 × 65 S** (balení obsahuje zápustné vruty **5 × 80**) | 4 | [KUTIL.cz](https://www.kutil.cz/spojovaci-material-a-kotevni-technika/kotevni-technika/vseobecne-hmozdinky/hmozdinka-duopower-fischer-8x65-1/), [srovnání cen na Heureka](https://www.heureka.cz/?h%5Bfraze%5D=hmo%C5%BEdinka+duopower+fischer+8x65), [technický list Fischer](https://www.fischer-cz.cz/cs-cz/products/bezne-hmozdinky/plastove-hmozdinky/duopower/538256-duopower-8x65-s) |
| Síť proti hmyzu, sklolaminátová, metráž (stačí kus 16 × 22 cm) | 1 | [UNI HOBBY – metráž šedá](https://unihobby.cz/sit-proti-hmyzu-sklovlaknita-metraz-seda), [BAUHAUS – sítě proti hmyzu](https://www.bauhaus.cz/site-proti-hmyzu-245270), [OBI – sítě proti hmyzu](https://www.obi.cz/ochrana-proti-hmyzu/ochranne-site-proti-hmyzu/c/2200), [Onpira – metráž](https://www.onpira.cz/zbozi/site-proti-hmyzu-skelne-vlakno/) |
| Vodítko (volitelné): 2 vruty 3,5 × 30 mm a hmoždinky 5 mm | 2 | [Heureka – hmoždinka 5 mm s vrutem](https://www.heureka.cz/?h%5Bfraze%5D=hmo%C5%BEdinka+5+mm+s+vrutem) |

Mechanismus i tyč jsou celé tištěné, na ovládání se nic nekupuje.

### Délka tyče

Tyč se skládá z dílů `tyc.stl` (každý 230 mm, parametr `tyc_dil`), mezi nimi
jsou spojky a dole rukojeť:

```
vzdálenost od spodku mřížky ke spodku rukojeti ≈ počet dílů × 233 mm + 17 mm
```

Příklad: mřížka má spodek ve 240 cm, rukojeť má být kolem 150 cm, tedy
90 cm: **4 díly** (949 mm, rukojeť ve 145 cm) a 3 spojky. Na přesnou délku
změňte `tyc_dil` (třeba 4 díly po 215 mm) a díly přegenerujte.

## Sestavení předního krytu

1. **Očistěte díly.** Lamela se musí v drážkách „U“ rámu otáčet volně. Když
   drhne, přejeďte čepy smirkem. Kotouč dorazu se musí volně otáčet
   v drážce ve dně.
2. Rám položte **lícem dolů** na stůl. Komora mechanismu je teď při pohledu
   zezadu **vpravo**.
3. **Vložte kotouč dorazu:** zezadu ho zasuňte čepem do drážky ve dně
   komory (kotouč projde výřezem ve spodku přepážky). Natočte ho do polohy
   **90°** (napůl): prostřední stupeň je na straně u vnější stěny rámu.
4. **Vložte lamely** jednu po druhé zezadu, čepem do drážek „U“. Každou
   natočte **napůl** (asi 41° od vodorovné), tak aby otevřená vidlice ramene
   mířila **rovně dozadu**, tedy kolmo od stolu nahoru.
5. **Zasuňte lištu** zezadu do komory, čepy k lamelám, nohou dolů. Čepy vjedou do vidlic všech lamel najednou (ústí vidlic jsou
   rozšířená, takže lamely nemusí být natočené přesně) a noha dosedne
   na prostřední stupeň kotouče.
6. **Zatlačte oba pojistné hřebínky** do vybrání na horní hraně přepážek,
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
7. **Vyzkoušejte chod:** otáčejte kotoučem za čep, který vyčnívá zespodu
   rámu (rám držte svisle, jak bude na zdi, lišta stojí vlastní vahou).
   Na 0°, 90° a 180° musí lamely zůstat stát, mezi nimi se musí otáčet
   všechny současně a lehce.
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
- **Ovládání:** mincí nebo plochým šroubovákem v hlubokém zářezu (3,5 mm);
  zamyká se **doprava** (po směru hodin při pohledu zepředu); zářez **svisle = zamčeno**,
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
   mincí nebo šroubovákem o **čtvrt otáčky doprava** (po směru hodin), až
   je zářez **svisle** a zámek cvakne. Zářez v hlavě klíče je 3,5 mm
   hluboký, mince nebo šroubovák se do něj dobře opře.
7. **Tyč:** díly tyče zasuňte do spojek a dole do rukojeti, až **cvaknou**
   (hroty jsou rozdělené a mají západky). Horní hrot zasuňte zespodu do
   čepu kotouče, až cvakne. Šestihran jde zasunout v šesti natočeních: když
   jsou lamely zavřené (0°, kotouč na dorazu), zasuňte rukojeť tak, aby
   šipka mířila **dopředu od zdi**. Po čtvrt otáčce (šipka do strany) je
   mřížka **napůl**, po půl otáčce (šipka **ke zdi**) **otevřená**. Opačným
   směrem se rukojeť neotočí, drží ji doraz ve vačce. Pevným tahem jdou
   hroty zase vytáhnout.
8. Pokud se tyč při točení houpe, přišroubujte doprostřed její délky
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
vytáhněte je, vytáhněte tyč z čepu kotouče a přední kryt sundejte. Montážní deska zůstane na zdi a síťka je
hned přístupná.

**Kupovaná síťka:** ze sklolaminátové sítě proti hmyzu ustřihněte obdélník
**159 × 211 mm** (pokryje celý otvor v límci). Přední kryt má pro síťku lůžko hluboké 0,25 mm, takže ji
montážní deska pevně stiskne.

**Tištěná síťka:** vytiskněte `zadni_deska_se_sitkou.stl` místo
`zadni_deska.stl`. Síťka je plochá mřížka v prvních dvou vrstvách montážní
desky: vlákna v obou směrech leží celou plochou na podložce, nic nevisí ve
vzduchu. Oka 1,2 × 1,2 mm, tloušťka **0,8 mm (4 vrstvy po 0,2 mm)**, aby
se síťka při sundávání z podložky nelámala (parametr `tistena_tl`). Tiskne se deskou dolů na čistou
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
- `tyc_s`, `tyc_dil`: tyč (šestihran konců přes plošky, délka dílu)
- `vacka_ploska`: šířka stupňů kotouče dorazu ve stupních (na každou stranu)
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
do komory ani do kotouče dorazu, čepy lišty zůstávají
v rovné části vidlic a lišta nenarazí na kotouč ani horní doraz. Teprve potom skript
vygeneruje STL, obrázky a animaci.

## Ladění

- **Rukojeť jde ztuha:** přejeďte smirkem stupně a náběhy kotouče a patku
  lišty, zkontrolujte, že se kotouč volně točí v drážce ve dně.
- **Lišta nesjíždí dolů na nižší stupeň:** lamely drhnou, uvolněte je
  (čepy v drážkách „U“, vidlice).
- **Hrot tyče drží v zásuvce málo nebo moc:** výšku západek mění `zub_v`
  v sekci *Hidden*.
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

Kdyby tyč překážela, dá se vytáhnout z čepu kotouče a nosit zvlášť jako
klíč: zasune se jen při ovládání.
