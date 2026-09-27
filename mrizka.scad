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
dil = "sestava"; // [sestava, rez, schema, mechanismus, rozlozeno, ram, zadni_deska, lamela, lista, pojistka, rukojet, voditko, spojka, klic, detail_uchyceni, vymena_sitky]
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
hloubka = 32;
// Tloušťka stěn a čelní plochy [mm]
stena = 3;
// Šířka bočního okraje (na straně táhla je v něm skrytá komora mechanismu) [mm]
bok = 20;
// Šířka bočního okraje na protější straně (bez mechanismu) [mm]; užší = širší průduch a síťka
bok_protejsi = 8;

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
tistena_tl = 0.4;

/* [Táhlo] */
// Průměr tyčky táhla (hliník / ocel / bukový kolík) [mm]
prumer_tycky = 6;
// Počet aretačních poloh (3 = zavřeno / půl / otevřeno)
pocet_poloh = 3;

/* [Montážní deska na zeď – Fischer DuoPower 8 x 65 S (vrut 5 x 80 zápustný)] */
// Zadní (montážní) deska zůstává na zdi; přední kryt s lamelami se k ní přišroubuje zepředu.
// Tloušťka montážní desky [mm]; DuoPower 8x65 + vrut 80 => max 10 (vrut musí jít 70 mm do hmoždinky)
tl_desky = 6;
// Vodorovná rozteč vrutů do zdi (2 nahoře, 2 dole) [mm]
roztec_sroubu = 100;
// Osa vrutu od horní/dolní hrany desky [mm]; co nejmenší = hmoždinka co nejdál od otvoru ve zdi
vrut_od_okraje = 8;
// Průměr průchozího otvoru pro vrut [mm]
prumer_sroubu = 5.5;
// Průměr zápustné hlavy vrutu [mm]
hlava_sroubu = 10;

/* [Přední kryt k montážní desce – 4 otočné zámky (princip Camloc/Dzus)] */
// Vodorovná rozteč zámků (2 nahoře, 2 dole) [mm]
roztec_klicu = 50;
// Prohnutí pružin v montážní desce při zamčení [mm] = přítlak krytu (menší = lehčí chod)
klic_predpeti = 0.3;
// Tloušťka listových pružin zámku v montážní desce [mm] (tlustší = tužší)
pruzina_tl = 1.5;

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
L_arm  = e/cos(alpha) + 1.6;  // délka ramene (vidlice přesahuje nejvzdálenější polohu čepu)
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
x_barc = (x_bar0 + x_bar1)/2;

// --- ovládací lišta ------------------------------------------------------
y_bar0 = st + 0.4;  y_bar1 = D - 0.3;
y_pin  = y_ax + e;
bar_bot0 = st + s_max;          // spodek lišty v poloze s = 0 (dole doráží na dno = zavřeno)
bar_top0 = zl(N-1) + 8;
y_rod  = 12;                    // osa tyčky (červík M3x5 se celý schová v liště)
d_sock = prumer_tycky + 0.3;
sock_h = 18;                    // hloubka zásuvky tyčky
z_grub = 7;                     // stavěcí šroub nad spodkem lišty
// pružná západka
L_j = 25; t_j = 2.5; g_j = 1.5; r_bump = 1.5;
tz0 = (bar_bot0 + bar_top0)/2 - L_j/2;   // volný konec jazýčku
z_bump0 = tz0 + 2.5;
function s_pos(k) = pocet_poloh < 2 ? 0 : -s_max + k*zdvih/(pocet_poloh-1);

// --- šrouby --------------------------------------------------------------
screw_pos = [for (zz = [vrut_od_okraje, H - vrut_od_okraje]) for (xx = [W/2 - roztec_sroubu/2, W/2 + roztec_sroubu/2]) [xx, zz]];
klic_pos  = [for (zz = [tb/2, H - tb/2]) for (xx = [W/2 - roztec_klicu/2, W/2 + roztec_klicu/2]) [xx, zz]];
// Otočný zámek podle principu Camloc/Dzus:
//  - klíč je plochý profil tištěný naplocho (tah jde podél vrstev): rukojeť-motýlek vpředu,
//    dřík skrz kryt a příčka vzadu,
//  - v montážní desce jsou dvě listové pružiny (nad a pod štěrbinou, tištěné naplocho);
//    příčka je při zamčení prohne o klic_predpeti a vznikne přítlak,
//  - v zamčené poloze příčka zapadne do mělké drážky v pružinách (aretace, sama se nepovolí),
//  - štěrbina v krytu je svislá, v desce vodorovná: klíč se zasune zepředu rukojetí svisle,
//    otočí se vodorovně a z krytu už nevypadne.
kl_t      = 5;                           // tloušťka klíče (tiskne se naplocho)
kl_d      = 6;                           // šířka dříku
kl_pl     = 14.6;                        // délka příčky
kl_pa     = 3.5;                         // tloušťka příčky ve směru osy
kl_vule   = 0.3;                         // vůle štěrbin
kl_rw     = 20;  kl_rh = 10;             // rukojeť: šířka, výška nad lícem
kl_boss   = 20;                          // průměr sloupku v krytu
pr_mezera = 0.7;                         // mezera před pružinou (pružina se prohne ke krytu)
ar_hl     = 0.2;                         // hloubka aretační drážky
pr_x      = 12;                          // polovina délky pružin
pr_z      = kl_pl/2 + 0.3;               // vnější hrana pružin (od osy)
pr_sterb  = 0.8;                         // štěrbina oddělující pružinu
pr_dutina = pr_z + pr_sterb;             // polovina výšky dutiny za pružinami
y_pruz    = D + pr_mezera + pruzina_tl;  // zadní (opěrná) plocha pružin
y_pricka  = y_pruz - ar_hl - klic_predpeti;   // přední plocha příčky (v aretaci prohne pružinu o klic_predpeti)

assert(sd >= 4 && sd <= 10, "Montážní deska musí mít 4-10 mm (vrut 5x80 musí jít aspoň 70 mm do hmoždinky 8x65).");
assert(tb/2 - pr_dutina >= 2, "Zámek v montážní desce je moc blízko okraje.");
assert(abs(roztec_sroubu - roztec_klicu)/2 >= pr_x + hlava_sroubu/2 + 1, "Vruty do zdi a zámky jsou moc blízko u sebe.");
assert(y_pricka + kl_pa <= D + sd - 0.3, "Příčka klíče se nevejde do montážní desky - zvětšete tl_desky.");
assert(klic_predpeti + ar_hl <= pr_mezera - 0.1, "Předpětí je větší, než kolik se pružina může prohnout.");
assert(tistena_tl >= 0.4, "Tištěná síťka musí mít aspoň 0,4 mm (dva průjezdy).");
assert(y_rod - prumer_tycky/2 - y_bar0 >= 5, "Červík M3x5 by vyčníval z lišty a drhl o čelo rámu - posuňte y_rod dozadu.");
assert(bok_protejsi >= 2*st + 1, "Protější boční okraj musí mít aspoň 2 stěny + 1 mm.");
assert(tb >= 14, str("Okraj nahoře/dole vychází jen ", tb, " mm - zvětšete výšku nebo uberte lamely."));
assert(p*cos(phic) > t + 0.2, "Lamely by do sebe v zavřené poloze narážely - zmenšete uhel_zavreni.");
assert(sb - 2*st >= 13, "Boční okraj je příliš úzký pro komoru mechanismu.");
assert(y_ax + sqrt(L_arm*L_arm + w_arm*w_arm/4) < D - 0.3, "Rameno by drhlo o zadní desku - zvětšete hloubku.");
assert(bar_bot0 + sock_h < tz0 - 3, "Zásuvka tyčky zasahuje do západky lišty.");

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
        rotate(alpha) hull() {
            translate([e - 0.2, 0]) circle(r = r_sl);
            translate([L_arm + 5, -r_sl]) square([eps, 2*r_sl]);
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
            // výstupek západky
            translate([x_bar0, y_bar0 + r_bump - 1.0, z_bump0]) rotate([0, 90, 0]) cylinder(r = r_bump, h = x_bar1 - x_bar0);
        }
        // pružný jazýček západky (kořen nahoře, volný konec dole)
        translate([x_bar0 - 1, y_bar0 + t_j, tz0 - 1.5]) cube([x_bar1 - x_bar0 + 2, g_j, L_j + 1.5]);
        translate([x_bar0 - 1, y_bar0 - 2, tz0 - 1.5]) cube([x_bar1 - x_bar0 + 2, t_j + g_j + 2, 1.5]);
        // zásuvka pro tyčku (kapka kvůli tisku na boku)
        translate([x_barc, y_rod, bar_bot0 - eps]) rotate([0, 0, 180]) teardrop_z(d_sock/2, sock_h);
        translate([x_barc, y_rod, bar_bot0 - eps]) cylinder(d1 = d_sock + 1.5, d2 = d_sock, h = 0.75);
        // stavěcí šroub M3 (zepředu)
        translate([x_barc, y_bar0 - 1, bar_bot0 + z_grub]) rotate([-90, 0, 0]) cylinder(d = 2.5, h = y_rod);
    }
}

// =====================================================================
//  PŘEDNÍ RÁM
// =====================================================================
module ram() {
    ram_telo();
    if (sitka == "kupovana") trny_sitky();
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
            for (q = klic_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) cylinder(d = kl_boss, h = D);
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
        if (luzko_tl > 0) translate([x_cav0 - st - 0.5, D - luzko_tl, tb - st - 0.5]) cube([sit_w + 1, 1, sit_h + 1]);
        // lůžka pojistných hřebínků
        for (xs = [x_cav0 - st, x_cav1])
            translate([xs - eps, D - st, tb - st - eps]) cube([st + 2*eps, st + 1, cav_h + 2*st + 2*eps]);
        // otvory pro otočné klíče: zápustné lůžko hlavy v líci a svislá štěrbina pro křídlo
        // průchod klíče: kruh pro otáčení dříku + svislá štěrbina pro příčku (pojistka proti vypadnutí)
        for (q = klic_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) translate([0, 0, -1]) linear_extrude(D + 2) {
            circle(d = sqrt(kl_d*kl_d + kl_t*kl_t) + 2*kl_vule);
            square([kl_t + 2*kl_vule, kl_pl + 2*kl_vule], center = true);
        }
        // průchod tyčky dnem rámu
        translate([x_barc, y_rod, -1]) rotate([0, 0, 90]) teardrop_z(prumer_tycky/2 + 0.5, st + 2);
        // přístupový otvor ke stavěcímu šroubu (lišta v poloze zavřeno)
        translate([x_barc, -1, st + z_grub]) rotate([-90, 0, 0]) cylinder(d = 3.5, h = st + 2);
        // drážky aretace v čelní stěně komory
        for (k = [0:max(pocet_poloh, 1)-1]) translate([x_bar0 - 0.5, st + 1.1, z_bump0 + s_pos(k)])
            rotate([0, 90, 0]) cylinder(r = 1.6, h = x_bar1 - x_bar0 + 1);
    }
}

// =====================================================================
//  POJISTNÝ HŘEBÍNEK  (zajišťuje čepy lamel v drážkách "U")
// =====================================================================
// y západky od konce prstu (výstupek na prstu i drážka ve stěně drážky "U" v krytu)
zap_y  = 1.5;
prst_w = 2*r_osa + 0.1;                 // šířka prstu
prst_y = y_ax + r_osa + 0.3;            // konec prstu (nad čepem lamely)
module pojistka(xs = 0) {
    tt = st - 0.2;
    flen = D - st + 0.2 - prst_y;
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
sit_w  = cav_w + 2*st;                        // plocha rámečku průduchu
sit_h  = cav_h + 2*st;
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
        // otvory pro trny síťky
        if (sitka == "kupovana") for (q = trny_pos) translate([q[0], D - 1, q[1]]) rotate([-90, 0, 0]) cylinder(d = 2, h = 1 + 1.6, $fn = 16);
        // zámky klíčů: vodorovná štěrbina pro křídlo a za ní kuželové lůžko otevřené ke zdi
        // (lokálně: x = vodorovně, y = svisle dolů, z = od čela desky ke zdi)
        for (q = klic_pos) translate([q[0], D, q[1]]) rotate([-90, 0, 0]) {
            yp = y_pruz - D;
            translate([-pr_x, -pr_dutina, yp]) cube([2*pr_x, 2*pr_dutina, sd]);                    // dutina za pružinami, otevřená ke zdi
            translate([-pr_x, -pr_dutina, -1]) cube([2*pr_x, 2*pr_dutina, 1 + pr_mezera]);         // mezera před pružinami
            for (s = [-1, 1]) translate([-pr_x, s > 0 ? pr_z : -pr_dutina, -1]) cube([2*pr_x, pr_sterb, sd + 2]);   // štěrbiny podél pružin
            translate([-(kl_pl/2 + kl_vule), -(kl_t/2 + kl_vule), -1]) cube([kl_pl + 2*kl_vule, kl_t + 2*kl_vule, sd + 2]);   // štěrbina pro příčku
            translate([0, 0, -1]) cylinder(d = sqrt(kl_d*kl_d + kl_t*kl_t) + 2*kl_vule, h = sd + 2);            // otvor pro otáčení dříku
            translate([-(kl_t/2 + 0.2), -pr_z, yp - ar_hl]) cube([kl_t + 0.4, 2*pr_z, ar_hl + eps]);    // aretační drážka (zamčeno)
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
// rukojeť na konec tyčky (tiskne se tak, jak je, otvorem nahoru)
module rukojet() {
    difference() {
        rotate_extrude($fn = 64) polygon([
            [0, 0], [12, 0], [14, 2], [14.5, 6], [13, 14], [9.5, 28], [8, 45], [8.5, 48], [7.5, 50], [0, 50]]);
        translate([0, 0, 50 - 30]) cylinder(d = d_sock, h = 31);
        translate([0, 0, 50 - 0.8]) cylinder(d1 = d_sock, d2 = d_sock + 1.6, h = 0.8 + eps);
        translate([0, 0, 42]) rotate([0, 90, 0]) cylinder(d = 2.5, h = 20);   // stavěcí šroub M3
    }
}

// vodítko tyčky na zeď (tyčku lze zacvaknout i dodatečně)
module voditko() {
    a = D + sd - y_rod;           // vzdálenost osy tyčky od zdi
    hh = 12;
    difference() {
        linear_extrude(hh) difference() {
            union() {
                translate([-15, 0]) square([30, 4]);
                translate([-3, 0]) square([6, a]);
                translate([0, a]) circle(d = prumer_tycky + 7);
            }
            translate([0, a]) circle(d = prumer_tycky + 0.4);
            translate([-(prumer_tycky - 0.9)/2, a]) square([prumer_tycky - 0.9, 10]);
        }
        for (x = [-10, 10]) translate([x, -1, hh/2]) rotate([-90, 0, 0]) {
            cylinder(d = 4.2, h = 6);
            translate([0, 0, 1 + 4 - 2]) cylinder(d1 = 4.2, d2 = 8.2, h = 2 + eps);
        }
    }
}

// spojka dvou tyček (tiskne se nastojato)
module spojka() {
    difference() {
        cylinder(d = prumer_tycky + 10, h = 50, $fn = 6*8);   // stěna 5 mm pro červík M3x5
        translate([0, 0, -1]) cylinder(d = d_sock, h = 52);
        for (z = [10, 40]) translate([0, 0, z]) rotate([0, 90, 0]) cylinder(d = 2.5, h = 20);
    }
}

// profil klíče (u = napříč, a = podél osy, a = 0 v líci krytu)
module klic_profil() {
    offset(r = 2) offset(delta = -2) translate([-kl_rw/2, -kl_rh]) square([kl_rw, kl_rh]);          // rukojeť (motýlek), dosedá na líc krytu
    translate([-kl_d/2, -1]) square([kl_d, y_pricka + kl_pa + 1]);                                  // dřík
    offset(r = 1) offset(delta = -1) translate([-kl_pl/2, y_pricka]) square([kl_pl, kl_pa]);         // příčka
}

// otočný klíč (osa +Z, líc krytu v z = 0, tloušťka podél Y); tiskne se naplocho
module klic() {
    intersection() {
        rotate([90, 0, 0]) linear_extrude(kl_t, center = true) klic_profil();
        // náběh: přední hrany příčky sražené 45°, příčka při otáčení najede na pružiny
        yz(-kl_rw, 2*kl_rw) union() {
            translate([-20, -50]) square([40, 50 + y_pricka + 0.05]);   // přesah, aby se plochy nekryly
            polygon([[-(kl_t/2 - 0.8), y_pricka], [kl_t/2 - 0.8, y_pricka], [40, y_pricka + 40.8], [-40, y_pricka + 40.8]]);
        }
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
    color("silver") translate([x_barc, y_rod, bar_bot0 + s + 2 - nahled_delka_tycky]) cylinder(d = prumer_tycky, h = nahled_delka_tycky + sock_h - 2);
    color("dimgray") translate([x_barc, y_rod, bar_bot0 + s + 2 - nahled_delka_tycky - 20]) rotate([180, 0, 0]) translate([0, 0, -50]) rukojet();
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
        translate([x_cav0 - st, D - luzko_tl, tb - st]) cube([sit_w - 0.5, luzko_tl, sit_h - 0.5]);
    color("lightsteelblue") translate([0, 2*explode, 0]) orez(rez) for (xs = [x_cav0 - st, x_cav1]) pojistka(xs);
    color("lightgray") translate([0, explode, 0]) orez(rez) for (i = [0:N-1]) lamela_na_miste(i, phi);
    color("darkorange") translate([explode*0.4, 0, 0]) orez(rez) lista(s);
    color("goldenrod") for (q = klic_pos) translate([0, -explode*1.5, 0]) klic_na_miste(q, explode == 0);
    if (tyc) tycka(s);
}

// natočení dílů pro tisk
module k_tisku(co) {
    if (co == "ram")         zrcadlo_tisk() translate([0, H, 0]) rotate([90, 0, 0]) ram();              // lícem dolů
    if (co == "zadni_deska") zrcadlo_tisk() translate([0, H, -D]) rotate([90, 0, 0]) zadni_deska();     // límcem nahoru
    if (co == "lamela")      zrcadlo_tisk() translate([0, 0, r_osa]) lamela_local();                    // rovnou stranou dolů
    if (co == "lista")       zrcadlo_tisk() translate([0, 0, x_bar1]) rotate([0, 90, 0]) lista(0);      // čepy nahoru
    if (co == "pojistka")    rotate([0, 90, 0]) translate([-(st - 0.2) - 0.1, 0, 0]) pojistka(0);
    if (co == "rukojet")     rukojet();
    if (co == "voditko")     voditko();
    if (co == "spojka")      spojka();
    if (co == "klic")        translate([0, 0, kl_t/2]) rotate([-90, 0, 0]) klic();       // naplocho
}

if (dil == "sestava")   sestava(phi_open);
if (dil == "rozlozeno") sestava(phi_open, 40);
if (dil == "rez")       sestava(phi_open, rez = true, tyc = false);
if (dil == "mechanismus") strana() {   // bez zadní desky, pohled zezadu
    s = s_of(phi_open);
    color("white") ram();
    color("lightgray") for (i = [0:N-1]) lamela_na_miste(i, phi_open);
    color("darkorange") lista(s);
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
    if (sitka == "kupovana") color("dimgray", 0.8) translate([x_cav0 - st, D - luzko_tl, tb - st]) cube([sit_w - 0.5, luzko_tl, sit_h - 0.5]);
    translate([0, -90, 0]) {
        color("white") ram();
        color("lightgray") for (i = [0:N-1]) lamela_na_miste(i, phi_open);
        color("darkorange") lista(s);
        color("lightsteelblue") for (xs = [x_cav0 - st, x_cav1]) pojistka(xs);
        color("goldenrod") for (q = klic_pos) klic_na_miste(q, false);
    }
}
if (dil == "detail_uchyceni") detail_uchyceni();

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
        translate([0.8, 0.8]) square([y_bar1 - y_bar0 - 1.6, bar_top0 - bar_bot0 - 1.6]);
    }
    color("darkorange") vrstva(5) for (i = [0:N-1]) translate([y_pin, zl(i) + s]) circle(r = r_cep);
    // tyčka
    color("black") vrstva(3.5) translate([y_rod - prumer_tycky/2, bar_bot0 + s - 90]) square([prumer_tycky, 90 + sock_h]);
    // osy
    color("black") vrstva(6) for (i = [0:N-1]) translate([y_ax, zl(i)]) circle(r = 0.8);
}
if (dil == "ram" || dil == "zadni_deska" || dil == "lamela" || dil == "lista" || dil == "pojistka"
    || dil == "rukojet" || dil == "voditko" || dil == "spojka" || dil == "klic") k_tisku(dil);
