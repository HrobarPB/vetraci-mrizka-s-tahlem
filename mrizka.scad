// =====================================================================
//  Větrací mřížka s žaluzií ovládanou svislým táhlem zespodu
//  (parametrický model pro 3D tisk, OpenSCAD 2021.01+)
//
//  Princip: vodorovné lamely se otáčejí na čepech. Na konci u táhla má
//  každá lamela vidlicové rameno. Do vidlic zapadají čepy svislé
//  ovládací lišty, která jezdí jen nahoru/dolů ve skryté boční komoře.
//  Do spodku lišty se zasune tyčka (táhlo) Ø6 mm, která vede dolů
//  k ruce.  Nahoru = otevřít, dolů = zavřít.  Pružná západka na liště
//  drží polohy zavřeno / napůl / otevřeno.
//
//  Souřadnice:  X = šířka (zleva doprava při pohledu zepředu)
//               Y = hloubka (0 = přední líc, kladně směrem do zdi)
//               Z = výška
//  Geometrie je popsaná pro mechanismus vpravo; varianta "vlevo"
//  (parametr ovladani) vznikne zrcadlením celé sestavy.
// =====================================================================

/* [Zobrazení] */
// Co vykreslit (díly "..." jsou už natočené pro tisk)
dil = "sestava"; // [sestava, rez, schema, mechanismus, rozlozeno, ram, zadni_deska, lamela, lista, pojistka_u_tahla, pojistka_protejsi, vacka, pist, kolik, tyc, spojka, rukojet, voditko, klic, detail_uchyceni, zamek_rez, hrebinek_detail, vymena_sitky]
// Poloha žaluzie: 0 = zavřeno, 1 = otevřeno
otevreni = 1; // [0:0.05:1]
// Na které straně (při pohledu zepředu na mřížku na zdi) je táhlo
ovladani = "vlevo"; // [vlevo, vpravo]
// Délka tyčky táhla pro náhled sestavy [mm]
nahled_delka_tycky = 250;

/* [Hlavní rozměry] */
// Vnější šířka rámu [mm]
sirka = 180;
// Vnější výška rámu [mm]
vyska = 250;
// Hloubka předního rámu (o kolik vystoupí ze zdi, bez zadní desky) [mm]
hloubka = 29.5;
// Tloušťka stěn a čelní plochy [mm]
stena = 3;
// Šířka bočního okraje (na straně táhla je v něm skrytá komora mechanismu) [mm]
bok = 20;
// Šířka bočního okraje na protější straně (bez mechanismu) [mm]; stejná jako na straně táhla = souměrný kryt
bok_protejsi = 20;

/* [Lamely] */
pocet_lamel = 10;
// Svislá rozteč os lamel [mm]
roztec = 20;
// Šířka (hloubka) lamely [mm]
sirka_lamely = 25;
tloustka_lamely = 2.4;
// Úhel natočení v zavřené poloze [°]  (musí platit roztec*cos(úhel) > tloušťka)
uhel_zavreni = 82;

/* [Otvor ve zdi, montážní deska a límec] */
// Světlý otvor ve zdi – šířka [mm]
otvor_sirka = 158;
// Světlý otvor ve zdi – výška [mm]
otvor_vyska = 208;
// Límec, který se zasune do otvoru ve zdi
limec = true;
// Vůle límce v otvoru na každou stranu [mm]
limec_vule = 1;
// Vnější šířka límce (0 = podle otvoru ve zdi) [mm]
limec_sirka = 0;
// Vnější výška límce (0 = podle otvoru ve zdi) [mm]
limec_vyska = 0;
limec_hloubka = 30;
limec_stena = 2;

/* [Síťka proti hmyzu] */
// Síťka sevřená mezi rámem a zadní deskou: kupovaná (ustřihnout na míru),
// tištěná (vytiskne se jako první vrstvy zadní desky), nebo žádná
sitka = "kupovana"; // [kupovana, tistena, zadna]
// Rozteč pevného roštu v zadní desce [mm]
rost_roztec = 22;
// Šířka žeber roštu [mm]
rost_zebro = 1.6;
// Hloubka lůžka pro kupovanou síťku v zadní straně rámu [mm]; o trochu méně než tloušťka síťky, aby ji sevřela
sitka_tl = 0.25;
// Tištěná síťka: rozteč vláken [mm] (otvor = rozteč - šířka vlákna)
tistena_roztec = 1.7;
tistena_vlakno = 0.5;
// Tloušťka tištěné síťky [mm]; celá leží na podložce, min. 0,4 = dva průjezdy po 0,2 mm
tistena_tl = 0.8;

/* [Táhlo – otočná vačka a tištěná šestihranná tyč] */
// Tyč: kulatá, na koncích šestihran; rozměr šestihranu přes plošky [mm]
tyc_s = 8;
// Délka jednoho dílu tyče [mm] (kolik se vejde na tiskovou podložku)
tyc_dil = 230;
// Ploché úseky drážky vačky na každou stranu od 0°, 90° a 180° [°]
vacka_ploska = 6;

/* [Montážní deska na zeď – Fischer DuoPower 8 x 65 S (vrut 5 x 80 zápustný)] */
// Zadní (montážní) deska zůstává na zdi; přední kryt s lamelami se k ní přišroubuje zepředu.
// Tloušťka montážní desky [mm]; DuoPower 8x65 + vrut 80 => max 10 (vrut musí jít 70 mm do hmoždinky)
tl_desky = 8;
// Vodorovná rozteč vrutů do zdi (2 nahoře, 2 dole) [mm]
roztec_sroubu = 100;
// Osa vrutu od horní/dolní hrany desky [mm]; co nejmenší = hmoždinka co nejdál od otvoru ve zdi
vrut_od_okraje = 8;
// Průměr průchozího otvoru pro vrut [mm]
prumer_sroubu = 5.5;
// Průměr zápustné hlavy vrutu [mm]
hlava_sroubu = 10;

/* [Přední kryt k montážní desce – 4 otočné zámky na čtvrt otáčky] */
// Vodorovná rozteč zámků (2 nahoře, 2 dole) [mm]
roztec_klicu = 50;
// Přesah příčky v aretaci [mm] = stálý přítlak krytu (menší = lehčí chod, větší = pevnější)
klic_predpeti = 0.3;
// Hloubka aretace [mm]: o kolik musí příčka vyjet, aby se zámek povolil
aretace_hl = 0.35;
// Tloušťka plného dna zámku v montážní desce [mm] (leží celou plochou na podložce)
dno_zamku = 2.4;

/* [Pojistné hřebínky] */
// Výška výstupků západky na prstech hřebínku [mm]; větší = drží pevněji, jde ztuha zatlačit
hrebinek_zapadka = 0.35;

/* [Hidden] */
$fn = 48;
eps = 0.01;

W = sirka; H = vyska; D = hloubka; st = stena; sb = bok; sd = tl_desky;
N = pocet_lamel; p = roztec; c = sirka_lamely; t = tloustka_lamely;
phic = uhel_zavreni;

// --- lamela a její osa -------------------------------------------------
d_osa = 5;  r_osa = d_osa/2;
v_off = r_osa - t/2;          // osa leží nad střednicí lamely -> spodek rovný pro tisk
r_hub = 2.8;                  // výztužné žebro kolem osy
gap   = 0.8;                  // vůle krajních lamel k rámu v zavřené poloze
y_ax  = st + (D - st)/2;      // hloubka osy lamel

// --- kinematika (kulisa: čep lišty ve vidlici ramene) -------------------
alpha  = phic/2;              // rameno svírá s lamelou alpha -> symetrický zdvih
e      = 7.5;                 // vodorovná vzdálenost čepu lišty od osy lamely
r_cep  = 2;                   // čep lišty Ø4
s_max  = e*tan(alpha);        // polovina zdvihu lišty
zdvih  = 2*s_max;
L_arm  = e/cos(alpha) + 2.2;  // délka ramene (vidlice přesahuje nejvzdálenější polohu čepu + rozšířené ústí)
usti_l = 1.8;                 // délka rozšířeného ústí vidlice
usti_w = 1.0;                 // o kolik se ústí rozšíří na každou stranu
w_arm  = 2*r_cep + 0.4 + 2*2.2;
t_arm  = 3;

// --- odvozené svislé rozměry --------------------------------------------
up  = (c/2 - t/2)*sin(phic) - v_off*cos(phic) + t/2;  // přesah zavřené lamely nad osu
dn  = (c/2 - t/2)*sin(phic) + v_off*cos(phic) + t/2;  // přesah pod osu
cav_h = (N-1)*p + up + dn + 2*gap;                    // světlá výška průduchu
tb  = (H - cav_h)/2;                                  // horní/dolní okraj
z1  = tb + gap + dn;
function zl(i) = z1 + i*p;

// --- vodorovné rozměry ---------------------------------------------------
x_cav0 = bok_protejsi; x_cav1 = W - sb;               // průduch (mechanismus je u x_cav1)
x_cc   = (x_cav0 + x_cav1)/2;                         // střed průduchu = střed límce a síťky
cav_w  = x_cav1 - x_cav0;
x_lam0 = x_cav0 + 0.5; x_lam1 = x_cav1 - 0.5;         // tělo lamely
x_kom0 = x_cav1 + st;  x_kom1 = W - st;               // komora mechanismu
x_arm0 = x_kom0 + 0.5; x_arm1 = x_arm0 + t_arm;
x_bar0 = x_arm1 + 0.5; x_bar1 = x_kom1 - 0.5;         // ovládací lišta

// --- ovládací lišta ------------------------------------------------------
y_bar0 = st + 0.4;  y_bar1 = D - 0.6;     // vzadu místo pro síťku přes komoru
y_pin  = y_ax + e;
bar_top0 = zl(N-1) + 8;

// --- válcová vačka (jako posuv čočky v objektivu / bajonet) -----------------------
// Tyč zespodu otáčí pouzdrem (vacka). V pouzdře jezdí neotočný píst s příčným kolíkem; oba konce
// kolíku vedou dvě protilehlé šroubové drážky pouzdra, takže pouzdro píst zvedá i stahuje.
// Píst je nahoře spojený s lištou rybinou (lišta ho drží proti otočení a píst ji táhne oběma směry).
// Drážky mají ploché úseky v 0°/90°/180° a končí pevnými dorazy. Polohy navíc cvaknou: píst má
// dva pružné jazýčky, které zapadnou do zářezů v dutině pouzdra (pružná západka).
vk_r    = 6.3;                   // vnější poloměr pouzdra
vk_ri   = 4.15;                  // poloměr dutiny pouzdra
vk_x    = x_kom1 - 0.2 - vk_r;   // osa
vk_y    = st + 0.4 + vk_r;
vk_czap = 6;                     // čep pouzdra pod dnem rámu (je v něm celá zásuvka tyče)
vk_krk  = 1.2;                   // krček nad čepem (kužel 45°) v zúžené horní části drážky ve dně
vk_krk_r = 4;                    // poloměr krčku dole
vk_dno  = 1.0;                   // dno pouzdra
vk_P0   = st + 1.5;              // spodek zadní části lišty v poloze zavřeno
pi_r    = vk_ri - 0.25;          // poloměr pístu
pi_b    = st + vk_dno + 0.3;     // spodek pístu v poloze zavřeno
ko_d    = 2.6;                   // průměr kolíku
dr_d    = ko_d + 0.3;            // šířka drážky
zp0     = pi_b + 1.2 + ko_d/2;   // výška kolíku v poloze zavřeno
vk_T    = zp0 + zdvih + dr_d/2 + 0.15 + 1.2;   // vršek pouzdra (strop drážky zkosený, seříznutý o 0,15 nad kruh)
pi_T    = vk_T + 0.5;            // vršek pístu v poloze zavřeno = strop vybrání lišty
ko_l    = 2*(vk_r - 0.2);        // délka kolíku (konce nevyčnívají z pouzdra)
za_hl   = 0.6;                   // hloubka zářezu západky v dutině pouzdra
ja_l    = 11;                    // délka pružného jazýčku pístu (od spodku pístu)
ry_x    = 1.25;                  // posun rybiny ke středu lišty (osa lišty je dál od ramen)
kz_y0   = vk_y + vk_r + 0.4;     // přední plocha zadní části lišty (za pouzdrem)
bar_bot0 = vk_P0 + s_max;// tištěná šestihranná tyč: hrot s pojistkou, zásuvky ve vačce, spojce a rukojeti
tyc_ac   = tyc_s/cos(30);       // přes rohy
hrot_l   = 6.5;                 // délka hrotu v zásuvce
zas_s    = tyc_s + 0.3;         // šestihran zásuvky
zas_h    = hrot_l + 0.3;
zub_h    = 1.5;                 // západka na konci hrotu
zub_v    = 0.5;                 // o kolik západka přečnívá roh šestihranu
vk_cep_r = zas_s/cos(30)/2 + 1.3;   // poloměr čepu kotouče ve dně (se zásuvkou)
tyc_d    = tyc_s;               // průměr kulaté části tyče (dole ploška se zkosením 45° pro tisk)
// zdvih pístu (a lišty) při natočení pouzdra fi (0 = zavřeno, 90 = napůl, 180 = otevřeno)
function vk_H(fi) = let(d = vacka_ploska, r = 90 - 2*d, h = zdvih/2)
    fi <= d ? 0 : fi < 90 - d ? h*(fi - d)/r : fi <= 90 + d ? h : fi < 180 - d ? h + h*(fi - 90 - d)/r : zdvih;
// natočení pouzdra podle polohy lišty
function vk_fi(s) = let(f = (s + s_max)/zdvih, d = vacka_ploska, r = 90 - 2*d)
    f <= 0.001 ? 0 : f < 0.499 ? d + r*f*2 : f <= 0.501 ? 90 : f < 0.999 ? 90 + d + r*(f - 0.5)*2 : 180;

// --- šrouby --------------------------------------------------------------
screw_pos = [for (zz = [vrut_od_okraje, H - vrut_od_okraje]) for (xx = [W/2 - roztec_sroubu/2, W/2 + roztec_sroubu/2]) [xx, zz]];
klic_pos  = [for (zz = [tb/2, H - tb/2]) for (xx = [W/2 - roztec_klicu/2, W/2 + roztec_klicu/2]) [xx, zz]];
// Otočný zámek na čtvrt otáčky se šroubovitým náběhem a půlkruhovou aretací:
//  - klíč: zápustná kulatá hlava v kuželovém lůžku v líci krytu (zarovnaná s lícem, otáčí
//    se v krytu, zakryje štěrbinu), kulatý dřík a půlkulatá příčka se zaoblenými konci
//    (rovnou stranou ke zdi); tiskne se nastojato příčkou dolů, hlava má zkosení 45°,
//    takže nic nepotřebuje podpěry; opěrné plochy jsou zaoblené a nevyrývají se do plastu,
//  - v montážní desce je za štěrbinou plné dno pevně spojené se zbytkem desky (tiskne se
//    celou plochou na podložce) a na něm šroubovitý náběh: příčka po něm najíždí a kryt
//    postupně přitahuje,
//  - na konci náběhu je půlkruhové lůžko přesně podle příčky (aretace) a za ním doraz,
//    doraz je i na druhé straně, takže se klíč točí jen správným směrem a jen o 90°;
//    dorazy jsou plné bloky přes celou hloubku kapsy, srostlé s její stěnou,
//  - štěrbina v krytu i v desce je vodorovná (stejný směr zasunutí): kryt se nasadí na desku,
//    vystředí ho obvodová polodrážka, pak se klíče zasunou zářezem vodorovně a otočí zářezem svisle.
// Obvodová polodrážka (lip and groove): límeček na zadní hraně stěn krytu zapadne do drážky
// v čele montážní desky po celém obvodu -> kryt je vystředěný ve všech směrech, spára je zakrytá.
// Límeček vyrůstá přímo ze stěny krytu (kryt se tiskne lícem dolů, límeček je nahoře),
// drážka je v čele desky (deska se tiskne čelem dolů, drážka je otevřená k podložce).
lem_a    = 1.4;                          // odsazení límečku od vnější hrany
lem_w    = 1.4;                          // tloušťka límečku (leží celý na stěně krytu)
lem_h    = 1.8;                          // výška límečku za zadní plochou krytu
lem_vule = 0.2;                          // vůle v drážce (na každou stranu)
lem_hl   = lem_h + 0.2;                  // hloubka drážky v desce
module obrys() square([W, H]);          // obrys zadní hrany krytu i montážní desky
module prstenec(a, w) difference() { offset(delta = -a) obrys(); offset(delta = -(a + w)) obrys(); }
kl_r      = 4;                           // poloměr dříku (profil D)
kl_lr     = 4;                           // poloměr půlkulaté příčky (rovná strana ke zdi)
kl_ll     = 8;                           // polovina délky příčky
kl_vule   = 0.3;                         // vůle průchodů
kl_hlava  = 17;                          // zápustná hlava v líci krytu (zakryje štěrbinu v každé poloze)
kl_hv     = 1;                           // válcová část hlavy, dál kužel 45° do dříku
kl_boss   = 2*(kl_ll + kl_vule) + 5;     // průměr sloupku v krytu
pr_x      = 12;                          // polovina šířky oblasti zámku
pr_z      = kl_ll + 0.4;                 // vnější hrana náběhu (od osy)
pr_dutina = kl_ll + kl_vule + 0.3;       // poloměr kulaté kapsy, ve které se točí příčka (okolo je deska plná)
kl_mezera = 0.1;                         // vůle příčky nad dnem v odemčené poloze
ar_hl     = aretace_hl;                  // výška hrany aretace nad přítlakem (cvaknutí)
h_det     = kl_mezera + klic_predpeti;   // výška náběhu pod příčkou v aretaci
h_pk      = h_det + ar_hl;               // vrchol náběhu
h_stop    = sd - dno_zamku;              // dorazy přes celou hloubku kapsy (až po zadní plochu desky)
y_pruz    = D + dno_zamku;               // zadní plocha dna zámku
y_pricka  = y_pruz + kl_mezera;          // přední (opěrná) plocha příčky
y_lug     = y_pricka + kl_lr;            // rovná (zadní) strana příčky

assert(lem_hl < dno_zamku - 0.3, "Drážka pro límeček by se protla s kapsou zámku.");
assert(lem_a + lem_w <= st, "Límeček musí ležet celý na stěně krytu.");
assert(sd >= 4 && sd <= 10, "Montážní deska musí mít 4-10 mm (vrut 5x80 musí jít aspoň 70 mm do hmoždinky 8x65).");
assert(tb/2 - pr_dutina >= 1.5, "Zámek v montážní desce je moc blízko okraje.");
assert(kl_hlava/2 <= tb/2 - 1.5, "Hlava klíče se nevejde do okraje krytu.");
assert(2*(kl_ll + kl_vule) < kl_hlava, "Hlava klíče musí zakrýt štěrbinu pro příčku.");
assert(abs(roztec_sroubu - roztec_klicu)/2 >= pr_x + hlava_sroubu/2 + 1, "Vruty do zdi a zámky jsou moc blízko u sebe.");
assert(y_lug <= D + sd - 0.3, "Příčka klíče se nevejde do montážní desky - zvětšete tl_desky.");
assert(tistena_tl >= 0.4, "Tištěná síťka musí mít aspoň 0,4 mm (dva průjezdy).");
assert(vk_x + vk_r <= x_kom1 - 0.2 && vk_x - vk_r >= x_kom0 + 0.4, "Pouzdro vačky se nevejde do komory.");
assert(-vk_czap + zas_h + 0.9 <= st - vk_krk, "Zásuvka tyče by se protla s krčkem pouzdra.");
assert(vk_x - pi_r >= x_arm1 + 0.1, "Píst by narážel do ramen lamel.");
assert(vk_ri - za_hl >= 0 && vk_r - vk_ri - za_hl >= 1.2, "Stěna pouzdra u zářezu je moc tenká.");
assert(bok_protejsi >= 2*st + 1, "Protější boční okraj musí mít aspoň 2 stěny + 1 mm.");
assert(tb >= 14, str("Okraj nahoře/dole vychází jen ", tb, " mm - zvětšete výšku nebo uberte lamely."));
assert(p*cos(phic) > t + 0.2, "Lamely by do sebe v zavřené poloze narážely - zmenšete uhel_zavreni.");
assert(sb - 2*st >= 13, "Boční okraj je příliš úzký pro komoru mechanismu.");
assert(y_ax + sqrt(L_arm*L_arm + w_arm*w_arm/4) < D - 0.3, "Rameno by drhlo o zadní desku - zvětšete hloubku.");


// stav žaluzie
phi_open = -phic*(1 - otevreni);          // úhel lamel (0 = vodorovně)
function s_of(phi) = e*tan(phi + alpha);  // poloha lišty pro daný úhel lamel

echo(str("Průduch: ", cav_w, " x ", cav_h, " mm, zdvih táhla: ", zdvih, " mm, okraj nahoře/dole: ", tb, " mm"));
zdivo = H/2 - otvor_vyska/2 - vrut_od_okraje - 4;   // plné zdivo mezi vývrtem Ø8 a otvorem ve zdi
echo(str("Hmoždinka: osa ", H/2 - otvor_vyska/2 - vrut_od_okraje, " mm od otvoru ve zdi, mezi vývrtem a otvorem zbývá ", zdivo, " mm zdiva"));
assert(otvor_sirka < W - 10 && otvor_vyska < H - 2*(vrut_od_okraje + 4) - 4, "Otvor ve zdi je na tuto mřížku moc velký - vruty by šly do otvoru.");
assert(vrut_od_okraje >= hlava_sroubu/2 + 2.5, "Vrut je moc blízko hrany desky - hlava by ji vylomila.");
assert(!limec || (lim_w <= otvor_sirka && lim_h <= otvor_vyska), "Límec je větší než otvor ve zdi.");

// =====================================================================
//  Pomocné moduly
// =====================================================================
// 2D profil v rovině (Y,Z) vytažený podél X od x0 o délku len
module yz(x0, len) multmatrix([[0,0,1,x0],[1,0,0,0],[0,1,0,0],[0,0,0,1]]) linear_extrude(len) children();

// otvor "kapka" (tisknutelný bez podpor) – osa podél Z, špička k +X
module teardrop_z(r, h) {
    linear_extrude(h) union() { circle(r); rotate(45) square(r); }
}

// =====================================================================
//  2D profily (používá je i kontrola kolizí)
// =====================================================================
// průřez lamely v jejích souřadnicích (u = po šířce, v = kolmo), osa v počátku
module lamela_profil() {
    intersection() {
        union() {
            translate([0, -v_off]) hull() {
                translate([-(c/2 - t/2), 0]) circle(d = t);
                translate([ (c/2 - t/2), 0]) circle(d = t);
            }
            circle(r = r_hub);
        }
        translate([-c, -r_osa]) square([2*c, 2*c]);
    }
}

// vidlicové rameno na pravém konci lamely
module rameno_profil() {
    r_sl = r_cep + 0.2;
    difference() {
        intersection() {
            hull() {
                circle(d = w_arm);
                rotate(alpha) translate([0, -w_arm/2]) square([L_arm, w_arm]);
                translate([0, -r_osa]) square([L_arm*cos(alpha) + w_arm/2*sin(alpha), eps]);
            }
            translate([-50, -r_osa]) square([100, 100]);
        }
        rotate(alpha) {
            hull() {
                translate([e - 0.2, 0]) circle(r = r_sl);
                translate([L_arm + 5, -r_sl]) square([eps, 2*r_sl]);
            }
            // rozšířené ústí: čep lišty najde vidlici, i když lamela není natočená přesně
            polygon([[L_arm - usti_l, -r_sl], [L_arm + eps, -r_sl - usti_w], [L_arm + eps, r_sl + usti_w], [L_arm - usti_l, r_sl]]);
        }
    }
}

// =====================================================================
//  LAMELA  (osa v počátku, podélně X)
// =====================================================================
module lamela_local() {
    yz(x_lam0, x_lam1 - x_lam0) lamela_profil();
    // levý čep
    yz(x_cav0 - st + 0.2, x_lam0 - (x_cav0 - st + 0.2) + eps) circle(r = r_osa);
    // pravá osa přes přepážku
    yz(x_lam1 - eps, x_arm0 - x_lam1 + 2*eps) circle(r = r_osa);
    // rameno s vidlicí
    yz(x_arm0, t_arm) rameno_profil();
}

module lamela_na_miste(i, phi) {
    translate([0, y_ax, zl(i)]) rotate([phi, 0, 0]) lamela_local();
}

// =====================================================================
//  OVLÁDACÍ LIŠTA  (s = svislý posun od střední polohy)
// =====================================================================
module lista(s = 0) {
    L_pin = x_bar0 - (x_kom0 + 0.3);
    translate([0, 0, s]) difference() {
        union() {
            translate([x_bar0, y_bar0, bar_bot0]) cube([x_bar1 - x_bar0, y_bar1 - y_bar0, bar_top0 - bar_bot0]);
            // čepy do vidlic
            for (i = [0:N-1]) translate([x_bar0 + eps, y_pin, zl(i)]) rotate([0, -90, 0]) {
                cylinder(r = r_cep, h = L_pin - 0.5 + eps);
                translate([0, 0, L_pin - 0.5]) cylinder(r1 = r_cep, r2 = r_cep - 0.5, h = 0.5);
            }
        }
        // vybrání pro pouzdro vačky (vpředu dole); strop vybrání leží na pístu, lišta se zasouvá zezadu
        translate([x_bar0 - 1, y_bar0 - 1, bar_bot0 - 1]) cube([x_bar1 - x_bar0 + 2, kz_y0 - y_bar0 + 1, 1 + lista_vybrani]);
        // drážka pro rybinu pístu, otevřená dopředu (lišta se nasune na píst zezadu)
        translate([vk_x, vk_y + 3.5 + 0.3, pi_T + s_max]) rotate([90, 0, 0]) linear_extrude(vk_y + 3.8 - y_bar0 + 1) rybina_profil(0.2);
    }
}
// výška vybrání v liště: strop vybrání = vršek pístu
lista_vybrani = pi_T - vk_P0;

// =====================================================================
//  PŘEDNÍ RÁM
// =====================================================================
module ram() {
    ram_telo();
    if (sitka == "kupovana") trny_sitky();
    // obvodový límeček: zapadne do drážky v montážní desce dřív, než se zasunou klíče
    // (špička se zúženým vnějším okrajem navede límeček do drážky)
    yz_plane(D - eps, lem_h - 0.4 + eps) prstenec(lem_a, lem_w);
    yz_plane(D + lem_h - 0.4, 0.4) prstenec(lem_a + 0.4, lem_w - 0.4);
}
module ram_telo() {
    ch = 1.5;
    difference() {
        union() {
            difference() {
                hull() {
                    translate([ch, 0, ch]) cube([W - 2*ch, D, H - 2*ch]);
                    translate([0, ch, 0]) cube([W, D - ch, H]);
                }
                translate([st, st, st]) cube([W - 2*st, D, H - 2*st]);
            }
            // rámeček průduchu (levá stěna s ložisky, horní a dolní stěna)
            difference() {
                translate([x_cav0 - st, 0, tb - st]) cube([cav_w + 2*st, D, cav_h + 2*st]);
                translate([x_cav0, -1, tb]) cube([cav_w, D + 2, cav_h]);
            }
            // pravá přepážka mezi průduchem a komorou (celá výška)
            translate([x_cav1, 0, 0]) cube([st, D, H]);
            // pouzdra šroubů do zdi
            // pouzdra montážních šroubků zadní desky
            for (q = klic_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) cylinder(d = kl_boss, h = D);   // sloupek zámku
            // horní doraz lišty (poloha "otevřeno")
            translate([x_bar0 - 0.3, 0, bar_top0 + s_max + 0.1]) cube([x_kom1 - x_bar0 + 0.3 + eps, D, H - st - (bar_top0 + s_max + 0.1) + eps]);
        }
        // čelní okno se sražením
        translate([x_cav0, -1, tb]) cube([cav_w, st + 2, cav_h]);
        hull() {
            translate([x_cav0 - 1, -eps, tb - 1]) cube([cav_w + 2, eps, cav_h + 2]);
            translate([x_cav0, 1, tb]) cube([cav_w, eps, cav_h]);
        }
        // ložiskové drážky "U" otevřené dozadu (levá stěna + pravá přepážka)
        for (xs = [x_cav0 - st, x_cav1]) for (i = [0:N-1])
            translate([xs - 1, y_ax, zl(i)]) hull() {
                rotate([0, 90, 0]) cylinder(r = r_osa + 0.2, h = st + 2);
                translate([0, D, 0]) rotate([0, 90, 0]) cylinder(r = r_osa + 0.2, h = st + 2);
            }
        // drážky pro západky hřebínků ve stěnách drážek "U"
        for (xs = [x_cav0 - st, x_cav1]) for (i = [0:N-1]) for (sg = [-1, 1]) {
            zf = zl(i) + sg*(r_osa + 0.2);
            yz(xs - 1, st + 2) polygon([[prst_y + zap_y - 0.8, zf - sg*0.01], [prst_y + zap_y, zf + sg*(hrebinek_zapadka + 0.1)], [prst_y + zap_y + 0.8, zf - sg*0.01]]);
        }
        // lůžko pro kupovanou síťku na zadní straně rámečku průduchu
        if (luzko_tl > 0) translate([x_cc - sit_w/2 - 0.5, D - luzko_tl, H/2 - sit_h/2 - 0.5]) cube([sit_w + 1, 1, sit_h + 1]);
        // lůžka pojistných hřebínků
        for (xs = [x_cav0 - st, x_cav1])
            translate([xs - eps, D - st, tb - st - eps]) cube([st + 2*eps, st + 1, cav_h + 2*st + 2*eps]);
        // otvory pro otočné klíče: zápustné lůžko hlavy v líci a svislá štěrbina pro křídlo
        // průchod klíče: kruh pro otáčení dříku + svislá štěrbina pro příčku (pojistka proti vypadnutí)
        for (q = klic_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) {
            translate([0, 0, -1]) cylinder(d = kl_hlava + 0.4, h = 1 + kl_hv);                   // zápustné lůžko hlavy
            translate([0, 0, kl_hv - eps]) cylinder(d1 = kl_hlava, d2 = 2*kl_r, h = kl_hlava/2 - kl_r);   // kužel přesně podle hlavy (určuje osovou polohu klíče)
            translate([0, 0, -1]) linear_extrude(D + 2) {
                circle(r = kl_r + kl_vule);
                offset(r = kl_vule) klic_silueta();                                           // vodorovná štěrbina, stejně jako v montážní desce
            }
        }
        // drážka ve dně pro čep pouzdra, otevřená dozadu (pouzdro se zasune zezadu); nahoře zúžená
        // na krček s kuželem 45°, takže pouzdro leží na dně a čep pod zúžením ho drží dole
        translate([0, 0, -1]) hull() {
            translate([vk_x, vk_y, 0]) cylinder(r = vk_cep_r + 0.25, h = st - vk_krk + 1);
            translate([vk_x - vk_cep_r - 0.25, D + 1, 0]) cube([2*(vk_cep_r + 0.25), eps, st - vk_krk + 1]);
        }
        translate([0, 0, st - vk_krk - eps]) hull() {
            translate([vk_x, vk_y, 0]) cylinder(r1 = vk_krk_r + 0.25, r2 = vk_krk_r + vk_krk + 0.25, h = vk_krk + 2*eps);
            translate([vk_x, D + 1, 0]) cylinder(r1 = vk_krk_r + 0.25, r2 = vk_krk_r + vk_krk + 0.25, h = vk_krk + 2*eps);
        }
    }
}

// =====================================================================
//  POJISTNÝ HŘEBÍNEK  (zajišťuje čepy lamel v drážkách "U")
// =====================================================================
// y západky od konce prstu (výstupek na prstu i drážka ve stěně drážky "U" v krytu)
zap_y  = 1.5;
prst_w = 2*r_osa + 0.1;                 // šířka prstu
prst_y = y_ax + r_osa + 0.3;            // konec prstu (nad čepem lamely)
// Protější hřebínek (na volně stojící stěně průduchu, daleko od táhla) má navíc žebra:
// vyplní mezeru mezi stěnou průduchu a vnější stěnou krytu a opřou se o ni, takže se
// hřebínek nemůže naklonit ani posunout do strany a výstupky prstů nevyskočí z drážek.
// Žebra jsou mezi prsty (prsty dál pruží), zespodu zkosená 45° (tisk naležato bez podpěr).
pojistka_zebro = 2.4;                   // tloušťka žebra
pojistka_zebro_vule = 0.15;             // vůle žebra k vnější stěně krytu
function pojistka_zebra_z() = concat([tb - st + 0.1 + pojistka_zebro/2],
    [for (i = [0:N-2]) (zl(i) + zl(i+1))/2],
    [tb + cav_h + st - 0.1 - pojistka_zebro/2]);
module pojistka(xs = 0, volna = false) {
    tt = st - 0.2;
    flen = D - st + 0.2 - prst_y;
    if (volna) {
        yd = D - st + 0.1;                        // spodek lišty hřebínku
        yh = yd + st - 0.15 - luzko_tl;           // vršek lišty hřebínku (pod síťkou)
        xo = st + pojistka_zebro_vule;            // vnitřní líc vnější stěny krytu + vůle
        for (zc = pojistka_zebra_z()) translate([0, 0, zc - pojistka_zebro/2]) linear_extrude(pojistka_zebro)
            polygon([[xs + 0.1 + eps, yd], [xs + 0.1 + eps, yh], [xo, yh], [xo, yd - (xs - 0.1 - xo)], [xs - 0.1, yd]]);
    }
    translate([xs + 0.1, 0, 0]) {
        translate([0, D - st + 0.1, tb - st + 0.1]) cube([tt, st - 0.15 - luzko_tl, cav_h + 2*st - 0.2]);
        for (i = [0:N-1]) translate([0, prst_y, zl(i) - prst_w/2]) difference() {
            union() {
                cube([tt, flen, prst_w]);
                // západka: výstupky se šikmými boky, zacvaknou do drážek v krytu (dají se i vytáhnout)
                yz(0, tt) {
                    polygon([[zap_y - 0.6, 0], [zap_y, -hrebinek_zapadka], [zap_y + 0.6, 0]]);
                    polygon([[zap_y - 0.6, prst_w], [zap_y, prst_w + hrebinek_zapadka], [zap_y + 0.6, prst_w]]);
                }
            }
            // podélná štěrbina: prst se rozdělí na dvě pružné poloviny
            translate([-1, -1, prst_w/2 - 0.5]) cube([tt + 2, 1 + 8, 1]);
        }
    }
}

// =====================================================================
//  ZADNÍ DESKA S LÍMCEM
// =====================================================================
// rozměry límce a síťky
lim_w  = limec_sirka > 0 ? limec_sirka : otvor_sirka - 2*limec_vule;
lim_h  = limec_vyska > 0 ? limec_vyska : otvor_vyska - 2*limec_vule;
lim_iw = lim_w - 2*limec_stena;               // světlost límce (tenké stěny)
lim_ih = lim_h - 2*limec_stena;
otv_w  = lim_iw;                              // otvor v zadní desce (s roštem)
otv_h  = lim_ih;
// síťka leží na zadní straně rámu přes celý rámeček průduchu a sevře ji zadní deska
sit_w  = max(cav_w + 2*st, otv_w + 8);        // síťka přes rámeček průduchu i celý otvor v desce
sit_h  = max(cav_h + 2*st, otv_h + 8);
luzko_tl = sitka == "kupovana" ? sitka_tl : 0;

module zadni_deska() {
    difference() {
        union() {
            translate([0, D, 0]) cube([W, sd, H]);
            if (limec) translate([x_cc - lim_w/2, D + sd - eps, H/2 - lim_h/2]) difference() {
                cube([lim_w, limec_hloubka, lim_h]);
                translate([(lim_w - lim_iw)/2, -1, (lim_h - lim_ih)/2]) cube([lim_iw, limec_hloubka + 2, lim_ih]);
            }
        }
        translate([x_cc - otv_w/2, D - 1, H/2 - otv_h/2]) cube([otv_w, sd + 2, otv_h]);
        // vruty do zdi: zápustná hlava v rovině čela desky, zakryje ji přední kryt
        for (q = screw_pos) translate([q[0], D, q[1]]) rotate([-90, 0, 0]) {
            translate([0, 0, -1]) cylinder(d = prumer_sroubu, h = sd + 2);
            translate([0, 0, -eps]) cylinder(d1 = hlava_sroubu + 0.6, d2 = prumer_sroubu, h = (hlava_sroubu + 0.6 - prumer_sroubu)/2);
        }
        // obvodová drážka pro límeček krytu (na vstupu rozšířená o 0,3 mm pro snadné navedení)
        yz_plane(D - 1, 1 + lem_hl) prstenec(lem_a - lem_vule, lem_w + 2*lem_vule);
        yz_plane(D - 1, 1 + 0.4) prstenec(lem_a - lem_vule - 0.3, lem_w + 2*lem_vule + 0.6);
        // otvory pro trny síťky
        if (sitka == "kupovana") for (q = trny_pos) translate([q[0], D - 1, q[1]]) rotate([-90, 0, 0]) cylinder(d = 2, h = 1 + 1.6, $fn = 16);
        // zámky klíčů: vodorovná štěrbina pro křídlo a za ní kuželové lůžko otevřené ke zdi
        // (lokálně: x = vodorovně, y = svisle dolů, z = od čela desky ke zdi)
        for (q = klic_pos) translate([q[0], D, q[1]]) rotate([-90, 0, 0]) {
            yp = y_pruz - D;
            translate([0, 0, yp]) cylinder(r = pr_dutina, h = sd, $fn = 96);                      // kulatá kapsa pro příčku; dno je plné od čela desky, okolo plná deska
            translate([0, 0, -1]) linear_extrude(sd + 2) { circle(r = kl_r + kl_vule); offset(r = kl_vule) klic_silueta(); }   // vodorovná štěrbina
        }
    }
    // pevný rošt v otvoru (podpírá síťku, zastaví ptáky)
    nx = max(1, round(otv_w/rost_roztec));
    nz = max(1, round(otv_h/rost_roztec));
    intersection() {
        translate([x_cc - otv_w/2, D, H/2 - otv_h/2]) cube([otv_w, sd, otv_h]);
        union() {
            for (i = [1:nx-1]) translate([x_cc - otv_w/2 + i*otv_w/nx - rost_zebro/2, D, 0]) cube([rost_zebro, sd, H]);
            for (k = [1:nz-1]) translate([0, D, H/2 - otv_h/2 + k*otv_h/nz - rost_zebro/2]) cube([W, sd, rost_zebro]);
        }
    }
    // šroubovité náběhy, aretace a dorazy zámků na dně
    for (q = klic_pos) translate([q[0], D, q[1]]) rotate([-90, 0, 0]) translate([0, 0, y_pruz - D - eps]) mirror([vlevo ? 1 : 0, 0, 0]) nabeh_zamku();   // zamyká se vždy doprava (po směru hodin zepředu)
    // tištěná síťka: první vrstvy montážní desky, deska se tiskne touto stranou dolů
    if (sitka == "tistena") translate([x_cc - otv_w/2 - 0.5, D, H/2 - otv_h/2 - 0.5]) {   // vlákna zasahují 0,5 mm do rámu
        // plochá mřížka: vlákna v obou směrech leží celou plochou na podložce, nic nevisí ve vzduchu
        yz_plane(0, tistena_tl) union() {
            for (x = [0.5 : tistena_roztec : otv_w + 0.5]) translate([x, 0]) square([tistena_vlakno, otv_h + 1]);
            for (z = [0.5 : tistena_roztec : otv_h + 0.5]) translate([0, z]) square([otv_w + 1, tistena_vlakno]);
        }
    }
}

// 2D (x, z) vytažený podél +Y o h od y0
module yz_plane(y0, h) translate([0, y0 + h, 0]) rotate([90, 0, 0]) linear_extrude(h) children();

// =====================================================================
//  PŘÍSLUŠENSTVÍ TÁHLA
// =====================================================================
// ---- tištěná šestihranná tyč -------------------------------------------
// hrot na konci tyče: rozdělený na dvě pružné poloviny, v rozích (po stranách při tisku)
// západka, která zaskočí do drážky v zásuvce; pevným tahem jde vytáhnout
module hrot_tyce() {
    difference() {
        union() {
            rotate(30) cylinder(d = tyc_ac, h = hrot_l, $fn = 6);
            // západky v bočních rozích (osa y), zkosené k hrotu
            for (sy = [-1, 1]) hull() {
                translate([-1.2, sy*(tyc_ac/2 - 0.5) - 0.01, hrot_l - zub_h - 0.6]) cube([2.4, 0.02, 0.01]);
                translate([-1.2, sy*(tyc_ac/2 + zub_v) - 0.01, hrot_l - zub_h]) cube([2.4, 0.02, zub_h - zub_v]);
                translate([-1.2, sy*(tyc_ac/2 - 0.3) - 0.01, hrot_l - 0.01]) cube([2.4, 0.02, 0.01]);
            }
        }
        translate([-tyc_s, -0.7, hrot_l - 12]) cube([2*tyc_s, 1.4, 13]);   // podélná štěrbina
    }
}
// zásuvka pro hrot (osa +Z, ústí v z = 0); drážka pro západku se zkoseným stropem (tisk bez podpěr)
module zasuvka_tyce() {
    translate([0, 0, -eps]) rotate(30) cylinder(d = zas_s/cos(30), h = zas_h + eps, $fn = 6);
    translate([0, 0, -eps]) rotate(30) cylinder(d1 = zas_s/cos(30) + 1, d2 = zas_s/cos(30), h = 0.5, $fn = 6);
    rz = tyc_ac/2 + zub_v + 0.3;
    translate([0, 0, hrot_l - zub_h - 0.3]) cylinder(r = rz, h = zub_h + 0.3);
    translate([0, 0, hrot_l - eps]) cylinder(r1 = rz, r2 = zas_s/cos(30)/2, h = rz - zas_s/cos(30)/2);
}
// díl tyče: kulatý, jen konce jsou šestihranné (tiskne se naležato na plošce, hroty na obou koncích)
module tyc_dil_m(l = tyc_dil) {
    k = 3;                                   // šestihranný nákružek u hrotu
    rotate(30) cylinder(d = tyc_ac, h = k + eps, $fn = 6);
    translate([0, 0, l - 2*hrot_l - k]) rotate(30) cylinder(d = tyc_ac, h = k + eps, $fn = 6);
    // kulatý průřez; dole (při tisku) ploška se zkosením 45°, aby spodek válce nevisel ve vzduchu
    linear_extrude(l - 2*hrot_l + eps) hull() {
        circle(d = tyc_d, $fn = 48);
        translate([tyc_d/2 - 0.01, -tyc_d/2*tan(22.5)]) square([0.01, tyc_d*tan(22.5)]);
    }
}
module tyc_cela(l = tyc_dil) {
    translate([0, 0, hrot_l]) tyc_dil_m(l);
    translate([0, 0, hrot_l]) rotate([180, 0, 0]) hrot_tyce();
    translate([0, 0, l - hrot_l]) hrot_tyce();
}
// spojka dvou dílů tyče (tiskne se nastojato)
module spojka() {
    h = 2*zas_h + 2;
    difference() {
        rotate(30) cylinder(d = (tyc_s + 5)/cos(30), h = h, $fn = 6);
        zasuvka_tyce();
        translate([0, 0, h]) rotate([180, 0, 0]) zasuvka_tyce();
    }
}
// rukojeť: knoflík s křidélkem na jednu stranu (páčka), šipka na křidélku ukazuje polohu
// (tiskne se zásuvkou nahoru)
module rukojet() {
    h = 26;
    difference() {
        union() {
            cylinder(d = 24, h = h);
            hull() { translate([0, -3.5, 0]) cube([36, 7, 4]); translate([0, -3.5, 0]) cube([30, 7, h - 4]); translate([34, 0, 0]) cylinder(r = 3.5, h = 4); }
        }
        translate([0, 0, h]) rotate([180, 0, 0]) zasuvka_tyce();
        // šipka na horní ploše křidélka (0° zavřeno, 90° napůl, 180° otevřeno)
        translate([24, 0, h - 5]) linear_extrude(2) polygon([[-5, -2.2], [4, 0], [-5, 2.2]]);
    }
}
// ---- válcová vačka: pouzdro, píst, kolík ----------------------------------------
// kolík (průměr d, radiálně od r0 do r1) ve směru psi v souřadnicích pouzdra natočeného o fi
// (strop drážky zkosený 45° se seříznutou špičkou, aby se pouzdro tisklo bez podpěr)
module kolik_v_pouzdru(psi, fi, d, r0, r1) rotate(psi - fi) translate([0, 0, zp0 + vk_H(fi)])
    rotate([0, 90, 0]) translate([0, 0, r0]) linear_extrude(r1 - r0) intersection() {
        hull() { circle(d = d, $fn = 20); translate([-d/2*sqrt(2), 0]) circle(d = 0.05); }
        translate([-d/2 - 0.15, -d]) square([2*d, 2*d]);
    }
// zářez západky (osa x = radiálně ven od stěny dutiny), V-profil se zkosenými stropy
module zarez() hull() {
    translate([-0.5, -1.4, -1.6]) cube([0.5, 2.8, 3.2]);
    translate([za_hl, -0.2, -0.6]) cube([0.01, 0.4, 1.2]);
}
// otočné pouzdro: osa v počátku, z = absolutní výška v rámu
module vacka() difference() {
    union() {
        translate([0, 0, -vk_czap]) cylinder(r = vk_cep_r, h = vk_czap + st - vk_krk);                // čep pod dnem
        translate([0, 0, st - vk_krk - eps]) cylinder(r1 = vk_krk_r, r2 = vk_krk_r + vk_krk, h = vk_krk + 2*eps);   // krček
        translate([0, 0, st]) cylinder(r = vk_r, h = vk_T - st, $fn = 96);
    }
    translate([0, 0, st + vk_dno]) cylinder(r = vk_ri, h = vk_T, $fn = 64);
    // dvě šroubové drážky = stopa obou konců kolíku (kolík ve směru ±y)
    for (psi = [90, 270]) for (f = [0 : 3 : 177]) hull() for (g = [f, f + 3]) kolik_v_pouzdru(psi, g, dr_d, vk_ri - 1, vk_r + 1);
    // zářezy západky v dutině: jazýčky pístu jsou ve směru ±x, zapadnou v 0°, 90° a 180°
    for (psi = [0, 180]) for (f = [0, 90, 180]) rotate(psi - f) translate([vk_ri, 0, zp0 + vk_H(f)]) zarez();
    translate([0, 0, -vk_czap]) zasuvka_tyce();
}
// rybina na vršku pístu (průřez x-z, x od osy), protažená ve směru y
module rybina_profil(c = 0) offset(delta = c) translate([ry_x, 0])
    polygon([[-1.75, -1], [1.75, -1], [1.75, 1], [3, 2.25], [3, 3.2], [-3, 3.2], [-3, 2.25], [-1.75, 1]]);
// neotočný píst v poloze zavřeno: kolík ve směru y, pružné jazýčky ve směru ±x, nahoře rybina
module pist() difference() {
    union() {
        translate([0, 0, pi_b]) cylinder(r = pi_r, h = pi_T - pi_b, $fn = 64);
        translate([0, 3.5, pi_T]) rotate([90, 0, 0]) linear_extrude(7) intersection() {
            rybina_profil(); translate([-10, 0]) square([20, 10]);
        }
        // nosy jazýčků
        for (sx = [-1, 1]) mirror([sx < 0 ? 1 : 0, 0, 0]) hull() {
            translate([pi_r - 0.9, -1.2, zp0 - 2]) cube([0.6, 2.4, 4]);          // boky nosu strmé (tisk)
            translate([vk_ri + za_hl - 0.15, -0.15, zp0 - 0.4]) cube([0.01, 0.3, 0.8]);
        }
    }
    // otvor pro kolík (kapka špičkou nahoru, tiskne se bez podpěr; kolík v něm drží natěsno)
    translate([0, 0, zp0]) rotate([90, 0, 0]) translate([0, 0, -pi_r - 1]) linear_extrude(2*pi_r + 2)
        hull() { circle(d = ko_d - 0.05, $fn = 24); translate([0, ko_d/2*sqrt(2)]) circle(d = 0.1); }
    // pružné jazýčky: kapsa za jazýčkem a boční štěrbiny, dole otevřené
    for (sx = [-1, 1]) mirror([sx < 0 ? 1 : 0, 0, 0]) translate([0, 0, pi_b - 1]) {
        translate([1.9, -2, 0]) cube([0.8, 4, ja_l + 1]);
        for (sy = [-1, 1]) translate([1.9, sy*1.75 - 0.25, 0]) cube([3, 0.5, ja_l + 1]);
    }
}
// kolík (osa z, tiskne se nastojato)
module kolik() cylinder(d = ko_d, h = ko_l, $fn = 24);
module vacka_na_miste(s) translate([vk_x, vk_y, 0]) rotate(vk_fi(s)) vacka();
module pist_na_miste(s) translate([vk_x, vk_y, vk_H(vk_fi(s))]) {
    pist();
    color("silver") translate([0, ko_l/2, zp0]) rotate([90, 0, 0]) kolik();
}

// vodítko tyčky na zeď (tyčku lze zacvaknout i dodatečně)
module voditko() {
    a = D + sd - vk_y;            // vzdálenost osy tyče od zdi
    hh = 12;
    difference() {
        linear_extrude(hh) difference() {
            union() {
                translate([-15, 0]) square([30, 4]);
                translate([-3, 0]) square([6, a]);
                translate([0, a]) circle(d = tyc_d + 7);
            }
            translate([0, a]) circle(d = tyc_d + 0.6);                           // kulatá tyč se v něm volně otáčí
            translate([-(tyc_s - 0.8)/2, a]) square([tyc_s - 0.8, 10]);          // zacvaknutí
        }
        for (x = [-10, 10]) translate([x, -1, hh/2]) rotate([-90, 0, 0]) {
            cylinder(d = 4.2, h = 6);
            translate([0, 0, 1 + 4 - 2]) cylinder(d1 = 4.2, d2 = 8.2, h = 2 + eps);
        }
    }
}

// obrys klíče při pohledu podél osy (příčka vodorovně = odemčeno), rovná plocha dole
module klic_silueta() {
    circle(r = kl_r);
    hull() for (sx = [-1, 1]) translate([sx*(kl_ll - kl_lr), 0]) circle(r = kl_lr);
}

// půlkulatá příčka podél X: rovná strana v z = 0 (ke zdi), oblá strana ke hlavě (-Z)
module pricka() {
    intersection() {
        hull() for (sx = [-1, 1]) translate([sx*(kl_ll - kl_lr), 0, 0]) sphere(r = kl_lr);
        translate([-50, -50, -50]) cube([100, 100, 50]);
    }
}

// otočný klíč: osa +Z, líc hlavy v z = 0 (zarovnaný s lícem krytu); zářez rovnoběžně s příčkou
module klic() {
    difference() {
        union() {
            cylinder(d = kl_hlava, h = kl_hv);                                                   // hlava
            translate([0, 0, kl_hv - eps]) cylinder(d1 = kl_hlava, d2 = 2*kl_r, h = kl_hlava/2 - kl_r);   // kužel 45°
            cylinder(r = kl_r, h = y_lug);                                                     // dřík
            translate([0, 0, y_lug]) pricka();                                                 // půlkulatá příčka
        }
        translate([-6.5, -0.9, -1]) cube([13, 1.8, 1 + 3.5]);                                 // hluboký zářez na minci / šroubovák
    }
}

// náběh na dně zámku (lokálně: z = 0 zadní plocha dna, úhel 0 = štěrbina, 90 = zamčeno)
module nabeh_zamku() {
    r0 = kl_r + kl_vule + 0.1;
    n  = 12;
    module sektor(a0, da, h, ri = r0) rotate(a0) rotate_extrude(angle = da, $fn = 96) polygon([[ri, 0], [pr_z + 1, 0], [pr_z + 1, h], [ri, h]]);
    difference() {
        intersection() {
            union() for (s = [0, 180]) rotate(s) {
                for (k = [0:n-1]) sektor(25 + k*35/n, 35/n + 0.3, h_pk*(k + 1)/n);   // šroubovitý náběh 25°-60°
                sektor(60, 62, h_pk);                                                  // vrchol
            }
            // jen na dně (ne ve štěrbině)
            for (sy = [-1, 1]) translate([-pr_x, sy > 0 ? kl_lr + kl_vule : -pr_z, 0]) cube([2*pr_x, pr_z - kl_lr - kl_vule, h_pk + 1]);
        }
        // půlkruhová aretace: lůžko přesně podle příčky v zamčené poloze
        translate([0, 0, y_lug - y_pruz + klic_predpeti]) rotate(90) pricka();
    }
    // dorazy: plné bloky přes celou hloubku kapsy až po zadní plochu desky, srostlé se stěnou
    // kapsy; rovná čela v rovině stěn štěrbiny. Každý blok zastaví jeden konec příčky
    // za aretací (90°) a druhý konec při otáčení špatným směrem (pod 0°), přes rovné čelo
    // se oblá příčka nepřetlačí.
    for (s = [0, 180]) rotate(s) intersection() {
        cylinder(r = pr_dutina + 0.5, h = h_stop, $fn = 96);
        translate([-(pr_dutina + 1), kl_lr + kl_vule, 0]) cube([pr_dutina + 1 - (kl_lr + kl_vule), pr_dutina + 1, h_stop]);
    }
}

// klíč na místě (zamčeno = rukojeť i příčka svisle)
module klic_na_miste(q, zamceno = true) {
    translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) rotate([0, 0, zamceno ? 90 : 0]) klic();
}

// trny, které na zadní straně krytu přidrží kupovanou síťku při nasazování
trny_pos = [for (zz = [tb - st/2, H - tb + st/2]) for (xx = [W/2 - roztec_sroubu/2, W/2 + roztec_sroubu/2]) [xx, zz]];
module trny_sitky() {
    for (q = trny_pos) translate([q[0], D - luzko_tl - eps, q[1]]) rotate([-90, 0, 0]) {
        cylinder(d = 1.0, h = 0.9, $fn = 16);
        translate([0, 0, 0.9 - eps]) cylinder(d1 = 1.0, d2 = 0.5, h = 0.4, $fn = 16);
    }
}

// =====================================================================
//  SESTAVY
// =====================================================================
module tycka(s) {
    fi = vk_fi(s);
    z0 = -vk_czap + hrot_l;                         // spodek čepu vačky = konec zásuvky
    translate([vk_x, vk_y, 0]) rotate(fi) {
        color("tan") translate([0, 0, z0 - nahled_delka_tycky]) tyc_dil_m(nahled_delka_tycky);
        color("dimgray") translate([0, 0, z0 - nahled_delka_tycky - hrot_l + 26 - zas_h]) rotate([180, 0, 0]) translate([0, 0, -26]) rukojet();
    }
}

// Model je navržený s mechanismem vpravo; pro levou variantu se zrcadlí.
vlevo = (ovladani == "vlevo");
module strana() {
    if (vlevo) translate([W, 0, 0]) mirror([1, 0, 0]) children();
    else children();
}
module zrcadlo_tisk() {
    if (vlevo) mirror([1, 0, 0]) children();
    else children();
}

module orez(k) {
    if (k) intersection() { children(); translate([-1, -1, -1]) cube([x_arm1 + 1 + eps, D + sd + limec_hloubka + 2, H + 2]); }
    else children();
}

module sestava(phi, explode = 0, rez = false, tyc = true) strana() {
    s = s_of(phi);
    color("white") orez(rez) ram();
    color("gainsboro") translate([0, 3*explode, 0]) orez(rez) zadni_deska();
    if (sitka == "kupovana") color("dimgray", 0.7) translate([0, 2.5*explode, 0]) orez(rez)
        translate([x_cc - sit_w/2 + 0.25, D - luzko_tl, H/2 - sit_h/2 + 0.25]) cube([sit_w - 0.5, luzko_tl, sit_h - 0.5]);
    color("lightsteelblue") translate([0, 2*explode, 0]) orez(rez) { pojistka(x_cav0 - st, true); pojistka(x_cav1); }
    color("lightgray") translate([0, explode, 0]) orez(rez) for (i = [0:N-1]) lamela_na_miste(i, phi);
    color("darkorange") translate([explode*0.4, 0, 0]) orez(rez) lista(s);
    color("peru") translate([explode*0.4, 0, -explode]) orez(rez) vacka_na_miste(s);
    color("sienna") translate([explode*0.4, 0, explode*0.3]) orez(rez) pist_na_miste(s);
    color("goldenrod") for (q = klic_pos) translate([0, -explode*1.5, 0]) klic_na_miste(q, explode == 0);
    if (tyc && nahled_delka_tycky > 0) tycka(s);
}

// natočení dílů pro tisk
module k_tisku(co) {
    if (co == "ram")         zrcadlo_tisk() translate([0, H, 0]) rotate([90, 0, 0]) ram();              // lícem dolů
    if (co == "zadni_deska") zrcadlo_tisk() translate([0, H, -D]) rotate([90, 0, 0]) zadni_deska();     // límcem nahoru
    if (co == "lamela")      zrcadlo_tisk() translate([0, 0, r_osa]) lamela_local();                    // rovnou stranou dolů
    if (co == "lista")       zrcadlo_tisk() translate([0, 0, x_bar1]) rotate([0, 90, 0]) lista(0);      // čepy nahoru
    if (co == "pojistka_u_tahla") rotate([0, 90, 0]) translate([-(st - 0.2) - 0.1, 0, 0]) pojistka(0);
    if (co == "pojistka_protejsi") zrcadlo_tisk() rotate([0, 90, 0]) translate([-(x_cav0 - st) - (st - 0.2) - 0.1, 0, 0]) pojistka(x_cav0 - st, true);   // žebry nahoru
    if (co == "rukojet")     rukojet();
    if (co == "vacka")       zrcadlo_tisk() translate([0, 0, vk_czap]) vacka();                        // čepem dolů
    if (co == "pist")        zrcadlo_tisk() translate([0, 0, -pi_b]) pist();                            // nastojato, rybinou nahoru
    if (co == "kolik")       kolik();                                                                  // nastojato
    if (co == "tyc")         translate([0, 0, tyc_s/2]) rotate([0, 90, 0]) rotate(0) tyc_cela();   // naležato na plošce
    if (co == "voditko")     voditko();
    if (co == "spojka")      spojka();
    if (co == "klic")        translate([0, 0, y_lug]) rotate([180, 0, 0]) klic();       // nastojato, rovnou stranou příčky dolů
}

if (dil == "sestava")   sestava(phi_open);
if (dil == "rozlozeno") sestava(phi_open, 40);
if (dil == "rez")       sestava(phi_open, rez = true, tyc = false);
if (dil == "mechanismus") strana() {   // bez zadní desky, pohled zezadu
    s = s_of(phi_open);
    color("white") ram();
    color("lightgray") for (i = [0:N-1]) lamela_na_miste(i, phi_open);
    color("darkorange") lista(s);
    color("peru") vacka_na_miste(s);
    color("sienna") pist_na_miste(s);
}
if (dil == "schema") schema(phi_open);
if (dil == "vymena_sitky") strana() {   // montážní deska zůstává na zdi, přední kryt je sundaný
    s = s_of(phi_open);
    color("tan") translate([-40, D + sd, -40]) difference() {
        cube([W + 80, 4, H + 80]);
        translate([40 + x_cc - otvor_sirka/2, -1, 40 + H/2 - otvor_vyska/2]) cube([otvor_sirka, 6, otvor_vyska]);
    }
    color("gainsboro") zadni_deska();
    color("steelblue") for (q = screw_pos) translate([q[0], D + 0.01, q[1]]) rotate([90, 0, 0]) cylinder(d = hlava_sroubu, h = 0.3);
    if (sitka == "kupovana") color("dimgray", 0.8) translate([x_cc - sit_w/2 + 0.25, D - luzko_tl, H/2 - sit_h/2 + 0.25]) cube([sit_w - 0.5, luzko_tl, sit_h - 0.5]);
    translate([0, -90, 0]) {
        color("white") ram();
        color("lightgray") for (i = [0:N-1]) lamela_na_miste(i, phi_open);
        color("darkorange") lista(s);
        color("lightsteelblue") { pojistka(x_cav0 - st, true); pojistka(x_cav1); }
        color("goldenrod") for (q = klic_pos) klic_na_miste(q, false);
    }
}
if (dil == "detail_uchyceni") detail_uchyceni();
if (dil == "zamek_rez") zamek_rez();
if (dil == "hrebinek_detail") intersection() {   // hřebínek vytažený z krytu: pružné prsty s výstupky a drážky v krytu
    union() {
        color("white") ram();
        color("lightsteelblue") translate([0, 14, 0]) pojistka(x_cav0 - st, true);
        color("lightgray") for (i = [0:1]) lamela_na_miste(i, 0);
    }
    translate([0, 0, 15]) cube([40, 60, 45]);
}

// řez osou zámku v zamčené poloze (2D): kryt, montážní deska s pružinami, klíč, zeď
module zamek_rez() {
    q = klic_pos[0];
    module rez() projection(cut = true) multmatrix([[0,1,0,0],[0,0,1,0],[1,0,0,-q[0]],[0,0,0,1]]) children();
    module okno() intersection() { children(); translate([-4, q[1] - 12]) square([D + sd + 16, 24]); }
    color("tan") vrstva(0) okno() translate([D + sd, -10]) square([12, 40]);
    color("dimgray") vrstva(1) okno() rez() ram();
    color("darkgray") vrstva(1) okno() rez() zadni_deska();
    color("darkorange") vrstva(2) okno() rez() klic_na_miste(q, true);
}

// řez rámem v místě šroubu (2D): zeď, hmoždinka DuoPower 8x65, vrut 5x80
module detail_uchyceni() {
    q = screw_pos[0];
    y_hl = D;                                    // hlava vrutu v rovině čela montážní desky
    wall = D + sd;
    module rez() projection(cut = true) multmatrix([[0,1,0,0],[0,0,1,0],[1,0,0,-q[0]],[0,0,0,1]]) children();
    module okno() intersection() { children(); translate([-5, -25]) square([wall + 95, tb + 40]); }
    // zeď s vývrtem Ø8 hloubky 85; nad okrajem otvor ve zdi (průduch)
    color("tan") vrstva(0) okno() difference() {
        translate([wall, -60]) square([120, 200]);
        translate([wall - 1, q[1] - 4]) square([86, 8]);
        translate([wall - 1, H/2 - otvor_vyska/2]) square([200, 200]);
    }
    color("dimgray") vrstva(1) okno() rez() ram();
    color("darkgray") vrstva(1) okno() rez() zadni_deska();
    // hmoždinka
    color("orange") vrstva(2) translate([wall, q[1] - 4]) difference() { square([65, 8]); translate([-1, 2]) square([67, 4]); }
    // vrut
    color("steelblue") vrstva(3) translate([y_hl, q[1]]) {
        polygon([[0, -hlava_sroubu/2], [0, hlava_sroubu/2], [(hlava_sroubu - 5)/2, 2.5], [(hlava_sroubu - 5)/2, -2.5]]);
        translate([0, -2.5]) square([79, 5]);
        polygon([[79, -2.5], [79, 2.5], [80, 0.5], [80, -0.5]]);
    }
}

// 2D schéma v bočním pohledu (zleva líc, vpravo zeď): Y -> vodorovně, Z -> svisle
module vrstva(k) translate([0, 0, k]) linear_extrude(0.5) children();

module schema(phi) {
    s = s_of(phi);
    wall_t = 60;
    // zeď s otvorem
    color("tan") vrstva(0) difference() {
        translate([D + sd, -60]) square([wall_t, H + 120]);
        translate([D + sd - 1, H/2 - otvor_vyska/2]) square([wall_t + 2, otvor_vyska]);
    }
    // rám v řezu komorou
    color("dimgray") vrstva(1) {
        square([st, H]);                                     // líc
        square([D, st]);                                     // dno
        translate([0, H - st]) square([D, st]);              // strop
        translate([0, bar_top0 + s_max + 0.1]) square([D, H - st - bar_top0 - s_max]);   // doraz
        difference() {                                       // zadní deska + límec
            union() {
                translate([D, 0]) square([sd, H]);
                if (limec) translate([D + sd, tb - limec_stena]) square([limec_hloubka, cav_h + 2*limec_stena]);
            }
            translate([D - 1, tb]) square([sd + limec_hloubka + 2, cav_h]);
        }
    }
    // lamely
    color("gray") vrstva(2) for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) lamela_profil();
    // ramena (poloprůhledně)
    color("steelblue") vrstva(4) for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) rameno_profil();
    // lišta
    color("darkorange") vrstva(3) translate([y_bar0, bar_bot0 + s]) difference() {
        square([y_bar1 - y_bar0, bar_top0 - bar_bot0]);
        translate([-1, -1]) square([kz_y0 - y_bar0 + 1, lista_vybrani + 1]);
    }
    color("darkorange") vrstva(5) for (i = [0:N-1]) translate([y_pin, zl(i) + s]) circle(r = r_cep);
    // vačka: pouzdro a píst s kolíkem, v řezu osou
    color("peru") vrstva(3.5) translate([vk_y, 0]) difference() {
        union() {
            translate([-vk_cep_r, -vk_czap]) square([2*vk_cep_r, vk_czap + st]);
            translate([-vk_r, st]) square([2*vk_r, vk_T - st]);
        }
        translate([-vk_ri, st + vk_dno]) square([2*vk_ri, vk_T]);
    }
    color("sienna") vrstva(3.6) translate([vk_y, s + s_max]) {
        translate([-pi_r, pi_b]) square([2*pi_r, pi_T - pi_b]);
        translate([-vk_r + 0.2, zp0 - ko_d/2]) square([2*vk_r - 0.4, ko_d]);
    }
    color("tan") vrstva(3.5) translate([vk_y - tyc_s/2, -90]) square([tyc_s, 90 - vk_czap]);
    // osy
    color("black") vrstva(6) for (i = [0:N-1]) translate([y_ax, zl(i)]) circle(r = 0.8);
}
if (dil == "ram" || dil == "zadni_deska" || dil == "lamela" || dil == "lista" || dil == "pojistka_u_tahla" || dil == "pojistka_protejsi"
    || dil == "rukojet" || dil == "voditko" || dil == "spojka" || dil == "klic" || dil == "vacka" || dil == "pist" || dil == "kolik" || dil == "tyc") k_tisku(dil);
