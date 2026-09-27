# Větrací mřížka s žaluzií ovládanou táhlem zespodu

Plastová větrací mřížka **180 × 250 mm** s nastavitelnou žaluzií, podobná
typu *Dalap GP 180×250 s mechanicky ovládanou žaluzií*. Rozdíl je v ovládání:
místo páčky na mřížce **visí ze spodku rámu tyčka s rukojetí**, takže
mřížku ve výšce ovládne i menší člověk ze země.
Tyčka je při pohledu zepředu **vlevo**. Na pravou stranu ji přepne parametr
`ovladani = "vpravo"`.

- **zatlačit tyčku nahoru → otevřeno**
- **stáhnout tyčku dolů → zavřeno**
- pružná západka drží tři polohy: **zavřeno / napůl / otevřeno**
- vzadu je **pevný rošt** a za ním **síťka proti hmyzu**, kupovaná nebo tištěná

Model je parametrický (OpenSCAD) a všechny díly se tisknou **bez podpěr**.

| Otevřeno | Zavřeno | Mechanismus (boční řez) |
|---|---|---|
| ![otevřeno](obrazky/sestava_otevreno.png) | ![zavřeno](obrazky/sestava_zavreno.png) | ![animace](obrazky/mechanismus.gif) |

## Jak to funguje

![mechanismus zezadu](obrazky/mechanismus.png)

1. Deset vodorovných lamel se otáčí na čepech v rámu.
2. Na konci u táhla má každá lamela **vidlicové rameno**. Rameno je schované
   v boční komoře rámu, zepředu ho není vidět.
3. V komoře jezdí svislá **ovládací lišta** (oranžová). Její čepy zapadají
   do vidlic všech lamel najednou.
4. Lišta se pohybuje jen nahoru a dolů, **zdvih je 13 mm**. Lamely se přitom
   otočí o 82° z vodorovné polohy do téměř svislé a zavřené lamely se
   překrývají.
5. Do spodku lišty se prostrčí dnem rámu **tyčka Ø 6 mm**. Drží ji stavěcí
   šroubek, který se utahuje malým otvorem v líci rámu.
6. Na přední straně lišty je **pružný jazýček s výstupkem**, který zapadá do
   drážek v čele rámu. Díky tomu lamely drží v nastavené poloze a tyčka
   nesjede vlastní vahou.
7. Krajní polohy mají pevné dorazy: dole dosedne lišta na dno rámu, nahoře
   narazí na doraz v komoře.

Rozložená sestava:

![rozloženo](obrazky/rozlozeno.png)

## Rozměry (výchozí nastavení)

| | |
|---|---|
| vnější rozměr rámu | 180 × 250 mm |
| vystoupení ze zdi | 35 mm (rám 32 + zadní deska 3) |
| světlý průduch | 140 × 206 mm |
| límec do otvoru ve zdi | 144 × 210 mm, hloubka 30 mm |
| rošt v zadní desce | oka cca 22 × 22 mm, žebra 1,6 mm |
| síťka proti hmyzu | ustřihnout na **139 × 205 mm** |
| lamely | 10 ks, rozteč 20 mm, šířka 25 mm |
| zdvih táhla | 13 mm |
| osa tyčky | vlevo, 8 mm od levého okraje a 23 mm od zdi |
| šrouby do zdi | 4× Fischer DuoPower 8 × 65 S, rozteč 100 mm vodorovně a 228 mm svisle, osa 11 mm od horní/dolní hrany rámu |

> **Změřte si otvor ve zdi.** Rozměry originálního límce Dalap jsem neměl
> k dispozici. Pokud je otvor jiný, nastavte `limec_sirka` a `limec_vyska`
> (nebo `limec = false`).

## Díly k tisku

Hotová STL jsou ve složce [`stl/`](stl). Jsou už natočená do tiskové polohy.

| Díl | Soubor | Ks | Poznámka k tisku |
|---|---|---|---|
| Přední rám | `ram.stl` | 1 | lícem dolů, potřebuje podložku aspoň **180 × 250 mm** |
| Zadní deska s límcem | `zadni_deska.stl` | 1 | deskou dolů |
| Lamela | `lamela.stl` | **10** | rovnou stranou dolů, rameno nahoru |
| Ovládací lišta | `lista.stl` | 1 | čepy nahoru, délka 214 mm |
| Pojistný hřebínek | `pojistka.stl` | **2** | naležato |
| Rukojeť | `rukojet.stl` | 1 | otvorem nahoru |
| Vodítko tyčky na zeď | `voditko.stl` | 0–2 | volitelné, když se tyčka moc houpe |
| Spojka tyčí | `spojka.stl` | 0–1 | volitelné, pro spojení dvou tyček |
| Krytka šroubu | `krytka.stl` | **6** | lícem dolů; 4 nad vruty do zdi, 2 nad šrouby M3 |
| Přítlačný rámeček síťky | `ramecek_sitky.stl` | 1 | pro kupovanou síťku; naplocho |
| Rámeček s tištěnou síťkou | `sitka_tistena.stl` | 1 | místo kupované síťky; síťkou dolů, viz [Síťka proti hmyzu](#síťka-proti-hmyzu) |

**Materiál:** PETG (do interiéru) nebo ASA (na přímé slunce, originál je
také z ASA). PLA nedoporučuji, protože pružná západka z PLA časem povolí
nebo praskne.
**Nastavení:** vrstva 0,2 mm, 3 perimetry, výplň 20 %, **bez podpěr**.
Lištu tiskněte se 4 perimetry, protože západka a čepy jsou namáhané nejvíc.

## Co koupit

| Položka | Ks | Kde koupit (příklady) |
|---|---|---|
| Hmoždinka **Fischer DuoPower 8 × 65 S** (balení obsahuje zápustné vruty **5 × 80**) | 4 | [KUTIL.cz](https://www.kutil.cz/spojovaci-material-a-kotevni-technika/kotevni-technika/vseobecne-hmozdinky/hmozdinka-duopower-fischer-8x65-1/), [srovnání cen na Heureka](https://www.heureka.cz/?h%5Bfraze%5D=hmo%C5%BEdinka+duopower+fischer+8x65), [technický list Fischer](https://www.fischer-cz.cz/cs-cz/products/bezne-hmozdinky/plastove-hmozdinky/duopower/538256-duopower-8x65-s) |
| Tyčka **Ø 6 mm**: hliníková kulatina (plná), délka dle výšky (viz níže) | 1 | [KUTIL.cz – tyč kruhová hliník 6 mm](https://www.kutil.cz/zelezarstvi/hutni-material/hlinikovy/tyc-kruhova-hlinik-6mm/), [ATREON – hliníková kulatina 6 mm](https://www.atreon.cz/hlinikova-kulatina-6-mm-en-6060/), [HORNBACH – trubka Ø 6 mm, 1 m](https://www.hornbach.cz/p/kulata-trubka-hlinikova-stribrna-o-6-mm-1m/6069570/) |
| Stavěcí šroub (červík) **M3 × 5**, DIN 913 / ISO 4026, imbus | 1 + 1 do rukojeti (+2 do spojky) | [PeckaModel – šrouby a červíky na imbus](https://www.peckamodel.cz/produkty/rc-modely-a-prislusenstvi/prislusenstvi/spojovaci-material/srouby-cerviky-imbus), [ATILASHOP – stavěcí šrouby](https://www.atilashop.cz/staveci-srouby-cerviky/), [KUTIL.cz – DIN 913](https://www.kutil.cz/spojovaci-material-a-kotevni-technika/srouby/imbus-vnitrni-sestihran/sroub-staveci-plochy-konec-imbus-din-913/) |
| Síť proti hmyzu, sklolaminátová, metráž (stačí kus 14 × 21 cm) | 1 | [UNI HOBBY – metráž šedá](https://unihobby.cz/sit-proti-hmyzu-sklovlaknita-metraz-seda), [BAUHAUS – sítě proti hmyzu](https://www.bauhaus.cz/site-proti-hmyzu-245270), [OBI – sítě proti hmyzu](https://www.obi.cz/ochrana-proti-hmyzu/ochranne-site-proti-hmyzu/c/2200), [Onpira – metráž](https://www.onpira.cz/zbozi/site-proti-hmyzu-skelne-vlakno/) |
| Imbusový klíč **1,5 mm** (na červíky) | 1 | [UNI HOBBY](https://www.unihobby.cz/imbus-klic-1-5mm-cv), [PeckaModel](https://www.peckamodel.cz/600900-klic-imbus-1-5mm), [Kavon (dlouhý)](https://www.kavon.cz/e-shop/wi-06059-49656/) |
| Šroub **M3 × 10**, DIN 912 válcová hlava (nebo zápustná DIN 7991), na spojení rámu se zadní deskou | 2 | [ProPrumysl](https://www.proprumysl.cz/sroub-valcova-hlava-inbus-din-912-m3x10-8-8-pozink/), [Prumex](https://www.prumex.cz/sroub-valcova-hlava-inbus-din-912-m3x10-8-8-pozink/), [MEPAC](https://www.mepac-eshop.cz/cs/sroub-valcova-hlava-imbus-m3x10-zb-din912-88-8590002029366) |
| Vodítko (volitelné): 2 vruty 3,5 × 30 mm a hmoždinky 5 mm | 2 | [Heureka – hmoždinka 5 mm s vrutem](https://www.heureka.cz/?h%5Bfraze%5D=hmo%C5%BEdinka+5+mm+s+vrutem) |

> **Červík musí být M3 × 5 (nebo kratší), ne delší.** V liště je pro něj přesně
> 5,6 mm místa. Delší červík by vyčníval a drhl o čelo rámu.

### Délka tyčky

```
délka tyčky ≈ (výška spodní hrany mřížky) − (výška, kde má být rukojeť) + 25 mm
```

Příklad: mřížka má spodek ve 240 cm a rukojeť má být ve 170 cm, tedy tyčka
72,5 cm. Rukojeť je v dosahu v obou polohách, protože zdvih je jen 13 mm.

## Sestavení

1. **Očistěte díly.** Lamela se musí v drážkách „U“ rámu otáčet volně. Když
   drhne, přejeďte čepy smirkem. Otvor v liště převrtejte vrtákem Ø 6 mm.
2. Rám položte **lícem dolů** na stůl. Komora mechanismu je teď při pohledu
   zezadu **vpravo**.
3. **Vložte lištu** do komory. Čepy musí směřovat k lamelám, výstupek
   západky ke stolu (k líci). Posuňte ji do **střední polohy**, kde cvakne
   prostřední drážka.
4. **Vkládejte lamely** jednu po druhé. Každou natočte tak, aby **otevřená
   vidlice ramene mířila kolmo od stolu**, a spusťte ji dolů. Čepy lamely
   zapadnou do drážek „U“ a vidlice nasedne na čep lišty. Všechny lamely
   budou pootevřené pod stejným úhlem.
5. **Nasaďte oba pojistné hřebínky** do vybrání na horní hraně přepážek.
   Jejich prsty zajistí čepy lamel v drážkách.
6. **Přiložte zadní desku.** Rám i s deskou opatrně otočte lícem nahoru
   a zepředu zašroubujte dva šrouby **M3 × 10** s válcovou hlavou do
   otvorů uprostřed nahoře a dole. Šroub projde rámem a závit si vyřízne do
   zadní desky. Otvory později zakryjí krytky.
   Pro šrouby se zápustnou hlavou přepněte `hlava_m3 = "zapustna"`: šrouby
   pak jdou zezadu skrz zadní desku do rámu.
7. **Vyzkoušejte chod:** prstem nebo kouskem tyčky zatlačte lištu otvorem ve
   dně nahoru a dolů. Lamely se musí otáčet všechny současně a západka musí
   cvakat ve třech polohách.
8. **Vložte síťku** (viz další kapitola).

## Síťka proti hmyzu

| Zezadu (kupovaná síťka) | Rozloženo (tištěná síťka) |
|---|---|
| ![zezadu](obrazky/zezadu_sitka.png) | ![rozloženo se síťkou](obrazky/rozlozeno_sitka.png) |

Zadní deska má v průduchu **pevný rošt**, který síťku podepře a nepustí
dovnitř ptáky. Síťka leží v límci na roštu, tedy na straně ke zdi, a drží ji
**přítlačný rámeček**. Ten zacvakne pod výstupky na vnitřních stěnách
límce. Vyměnit se dá bez nářadí, jen je potřeba mřížku sundat ze zdi.

**Kupovaná síťka:** ze sklolaminátové sítě proti hmyzu ustřihněte obdélník
**139 × 205 mm**. Položte ho do límce na rošt a zatlačte rámeček
(`ramecek_sitky.stl`), až cvakne.

**Tištěná síťka:** `sitka_tistena.stl` je rámeček, na kterém je rovnou
tenká síťka. Má dvě vrstvy vláken křížem, oka 1,2 × 1,2 mm a tloušťku
0,4 mm. Vložte ji síťkou k roštu místo kupované síťky a rámečku.
Tisk: síťkou dolů na čistou podložku, výška vrstvy **0,2 mm**, šířka
extruze 0,45–0,5 mm, bez límce (brim) a bez „ironing“. Rozteč a šířku vláken
lze změnit parametry `tistena_roztec` a `tistena_vlakno`. Pokud slicer
vlákna vynechá, zvětšete `tistena_vlakno` na 0,6.

Lem a rošt uberou asi 18 % průřezu, síťka proti hmyzu dalších zhruba 30–40 %.
S tím je potřeba počítat, pokud je větrání na hraně.


## Montáž na zeď (Fischer DuoPower 8 × 65 S)

![detail uchycení](obrazky/detail_uchyceni.png)

Vrut 5 × 80 z balení musí jít do hmoždinky 8 × 65 aspoň **70 mm**. Může tedy
sevřít nejvýš 10 mm materiálu. Rám je ale hluboký 35 mm, a proto jsou šrouby
**zapuštěné hluboko do rámu**. Zápustná hlava dosedne na patku těsně u zdi,
která se zadní deskou měří 8 mm (vrut jde do hmoždinky 72 mm). Otvor Ø 12 mm
nad hlavou zakryje zepředu tisknutá **krytka**.

1. Límec zasuňte do otvoru ve zdi a srovnejte mřížku do vodováhy.
2. Tužkou nebo vrtákem Ø 5 mm (jen ťuknout) označte na zdi 4 otvory skrz
   rám. Mřížku sundejte.
3. Vyvrtejte díry **Ø 8 mm, hloubka aspoň 85 mm**. Do cihly a porobetonu
   vrtejte bez příklepu. Vyfoukejte prach.
4. Hmoždinky zatlučte **do roviny zdi**.
5. Nasaďte mřížku a zašroubujte vruty 5 × 80 skrz otvory v líci.
   Potřebujete bit s dlouhým nástavcem, protože hlava sedí 27 mm hluboko
   a otvor má Ø 12 mm. Utahujte citlivě, aby hlava nepraskla plast patky.
6. Zacvakněte 6 krytek (4 nad vruty do zdi, 2 nad šrouby M3).
7. **Táhlo:** stáhněte lištu úplně dolů (zavřeno). Zespodu zasuňte tyčku
   otvorem ve dně až na doraz do lišty (18 mm). Klíčem 1,5 mm utáhněte
   červík **malým otvorem v líci rámu vlevo dole**.
8. Na spodní konec tyčky nasaďte **rukojeť**. Zajistěte ji druhým červíkem
   nebo lepidlem.
9. Pokud se tyčka houpe, přišroubujte doprostřed její délky **vodítko**.
   Tyčka se do něj dá zacvaknout i dodatečně.

> ⚠️ **Vzdálenost od okraje otvoru ve zdi.** Osa šroubu je jen 11 mm od
> horní a dolní hrany rámu. Kdyby otvor ve zdi byl stejně velký jako límec
> (210 mm), zbylo by mezi vývrtem Ø 8 a otvorem jen asi 5 mm zdiva a to se při
> utahování vylomí. Hmoždinka potřebuje kolem sebe plné zdivo
> (minimální vzdálenost od okraje najdete v technickém listu Fischer pro
> váš materiál). Pokud je otvor ve zdi kulatý (trubka) nebo menší, je to
> v pořádku. Jinak rám zvětšete (`vyska`) nebo změňte `roztec_sroubu`.

## Úpravy modelu

Otevřete `mrizka.scad` v [OpenSCAD](https://openscad.org) (2021.01 nebo
novější). V panelu *Customizer* lze měnit hlavně:

- `ovladani`: strana táhla při pohledu zepředu (`vlevo` nebo `vpravo`)
- `sirka`, `vyska`: vnější rozměr rámu
- `pocet_lamel`, `roztec`, `sirka_lamely`: počet a velikost lamel.
  Světlý průduch a okraje se dopočítají samy.
- `limec_sirka`, `limec_vyska`, `limec_hloubka`: límec do otvoru ve zdi
- `roztec_sroubu`, `tl_upevneni`, `hlava_sroubu`, `zahloubeni`: uchycení na
  zeď (výchozí hodnoty pro Fischer DuoPower 8 × 65 S s vrutem 5 × 80)
- `hlava_m3`: hlava šroubů M3 × 10 pro spojení zadní desky (`valcova`
  zepředu pod krytkou / `zapustna` zezadu)
- `sitka`: `kupovana`, `tistena` nebo `zadna`; `rost_roztec`, `rost_zebro`:
  pevný rošt; `tistena_roztec`, `tistena_vlakno`: tištěná síťka
- `prumer_tycky`: průměr tyčky, například 8 mm pro silnější kolík
- `pocet_poloh`: počet aretačních poloh (3 nebo 5)
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
do komory a čepy lišty zůstávají ve vidlicích. Teprve potom skript
vygeneruje STL, obrázky a animaci.

## Ladění

- **Západka drží málo nebo moc:** výstupek na liště lze zabrousit, nebo
  změnit `r_bump`, `t_j` (tloušťka jazýčku) či `L_j` (délka jazýčku)
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

Kdyby tyčka překážela:

- **šňůrka se dvěma konci** (jako u rolet): vyžaduje kladku nahoře a vratnou
  pružinu, což je složitější a méně spolehlivé,
- **háček na tyči**, který se nosí zvlášť: do spodku lišty by se místo
  tyčky tiskl krátký kroužek.

Pevná tyčka je nejjednodušší a funguje oběma směry: tlačit i táhnout.
