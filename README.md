# Větrací mřížka s žaluzií ovládanou táhlem zespodu

Plastová větrací mřížka **180 × 250 mm** s nastavitelnou žaluzií, podobná
typu *Dalap GP 180×250 s mechanicky ovládanou žaluzií*. Rozdíl je v ovládání:
místo páčky na mřížce **visí ze spodku rámu tyčka s rukojetí**, takže
mřížku ve výšce ovládne i menší člověk ze země.

- **zatlačit tyčku nahoru → otevřeno**
- **stáhnout tyčku dolů → zavřeno**
- pružná západka drží tři polohy: **zavřeno / napůl / otevřeno**

Model je parametrický (OpenSCAD) a všechny díly se tisknou **bez podpěr**.

| Otevřeno | Zavřeno | Mechanismus (boční řez) |
|---|---|---|
| ![otevřeno](obrazky/sestava_otevreno.png) | ![zavřeno](obrazky/sestava_zavreno.png) | ![animace](obrazky/mechanismus.gif) |

## Jak to funguje

![mechanismus zezadu](obrazky/mechanismus.png)

1. Deset vodorovných lamel se otáčí na čepech v rámu.
2. Na pravém konci má každá lamela **vidlicové rameno**. Rameno je schované
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
| lamely | 10 ks, rozteč 20 mm, šířka 25 mm |
| zdvih táhla | 13 mm |
| osa tyčky | 25 mm od zdi, 8 mm od pravého okraje |
| šrouby do zdi | 4 ks, rozteč 100 mm vodorovně, 228 mm svisle |

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

**Materiál:** PETG (do interiéru) nebo ASA (na přímé slunce, originál je
také z ASA). PLA nedoporučuji, protože pružná západka z PLA časem povolí
nebo praskne.
**Nastavení:** vrstva 0,2 mm, 3 perimetry, výplň 20 %, **bez podpěr**.
Lištu tiskněte se 4 perimetry, protože západka a čepy jsou namáhané nejvíc.

## Co koupit

| Položka | Ks |
|---|---|
| Tyčka **Ø 6 mm**: hliníková kulatina, ocel nebo bukový kolík, délka dle výšky (viz níže) | 1 |
| Stavěcí šroub (červík) **M3 × 5**, ISO 4026, a imbusový klíč 1,5 mm | 1 (+1 do rukojeti) |
| Vruty do zdi 4 × 50 mm se zápustnou hlavou a hmoždinky 6 mm | 4 |
| Vruty 2,9 × 13 mm se zápustnou hlavou (nebo M3 × 12) na spojení rámu se zadní deskou | 2 |
| Vodítko (volitelné): 2 vruty 3,5 × 30 mm a hmoždinky 5 mm | 2 |

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
   zezadu **vlevo**.
3. **Vložte lištu** do komory. Čepy musí směřovat k lamelám, výstupek
   západky ke stolu (k líci). Posuňte ji do **střední polohy**, kde cvakne
   prostřední drážka.
4. **Vkládejte lamely** jednu po druhé. Každou natočte tak, aby **otevřená
   vidlice ramene mířila kolmo od stolu**, a spusťte ji dolů. Čepy lamely
   zapadnou do drážek „U“ a vidlice nasedne na čep lišty. Všechny lamely
   budou pootevřené pod stejným úhlem.
5. **Nasaďte oba pojistné hřebínky** do vybrání na horní hraně přepážek.
   Jejich prsty zajistí čepy lamel v drážkách.
6. **Přiložte zadní desku** a přišroubujte ji dvěma vruty 2,9 × 13
   (uprostřed nahoře a dole).
7. **Vyzkoušejte chod:** prstem nebo kouskem tyčky zatlačte lištu otvorem ve
   dně nahoru a dolů. Lamely se musí otáčet všechny současně a západka musí
   cvakat ve třech polohách.

## Montáž na zeď

1. Límec zasuňte do otvoru ve zdi a srovnejte mřížku do vodováhy.
2. Otvory v rámu označte a vyvrtejte 4 díry pro hmoždinky 6 mm.
3. Mřížku přišroubujte vruty 4 × 50.
4. **Táhlo:** stáhněte lištu úplně dolů (zavřeno). Zespodu zasuňte tyčku
   otvorem ve dně až na doraz do lišty (18 mm). Klíčem 1,5 mm utáhněte
   stavěcí šroub **malým otvorem v líci rámu vpravo dole**.
5. Na spodní konec tyčky nasaďte **rukojeť**. Zajistěte ji druhým červíkem
   nebo lepidlem.
6. Pokud se tyčka houpe, přišroubujte doprostřed její délky **vodítko**.
   Tyčka se do něj dá zacvaknout i dodatečně.

## Úpravy modelu

Otevřete `mrizka.scad` v [OpenSCAD](https://openscad.org) (2021.01 nebo
novější). V panelu *Customizer* lze měnit hlavně:

- `sirka`, `vyska`: vnější rozměr rámu
- `pocet_lamel`, `roztec`, `sirka_lamely`: počet a velikost lamel.
  Světlý průduch a okraje se dopočítají samy.
- `limec_sirka`, `limec_vyska`, `limec_hloubka`: límec do otvoru ve zdi
- `sitka = true`: síťka proti hmyzu v zadní desce
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
