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
dil = "sestava"; // [sestava, rez, schema, mechanismus, rozlozeno, ram, zadni_deska, lamela, lista, pojistka, rukojet, voditko, spojka, klic, kridlo_klice, detail_uchyceni, vymena_sitky]
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

/* [Lamely] */
pocet_lamel = 10;
// Svislá rozteč os lamel [mm]
roztec = 20;
// Šířka (hloubka) lamely [mm]
sirka_lamely = 25;
tloustka_lamely = 2.4;
// Úhel natočení v zavřené poloze [°]  (musí platit roztec*cos(úhel) > tloušťka)
uhel_zavreni = 82;

/* [Zadní deska a límec do zdi] */
// Límec, který se zasune do otvoru ve zdi
limec = true;
// Vnější šířka límce (0 = automaticky podle průduchu) [mm]
limec_sirka = 0;
// Vnější výška límce (0 = automaticky podle průduchu) [mm]
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
// Průměr průchozího otvoru pro vrut [mm]
prumer_sroubu = 5.5;
// Průměr zápustné hlavy vrutu [mm]
hlava_sroubu = 10;

/* [Přední kryt k montážní desce – 4 tištěné otočné klíče] */
// Vodorovná rozteč klíčů (2 nahoře, 2 dole) [mm]
roztec_klicu = 50;
// Předpětí klíče [mm]: o kolik křídlo přitáhne kryt k desce (0 = bez předpětí, volnější)
klic_predpeti = 0.15;

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
x_cav0 = sb;           x_cav1 = W - sb;               // průduch
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
screw_pos = [for (zz = [tb/2, H - tb/2]) for (xx = [W/2 - roztec_sroubu/2, W/2 + roztec_sroubu/2]) [xx, zz]];
klic_pos  = [for (zz = [tb/2, H - tb/2]) for (xx = [W/2 - roztec_klicu/2, W/2 + roztec_klicu/2]) [xx, zz]];
// otočný klíč: zápustná hlava v líci krytu, dřík skrz kryt, na konci křídlo, které se
// v montážní desce otočí o 90° za okraj štěrbiny (odemčeno = křídlo vodorovně)
kl_d      = 6;                           // dřík
kl_hlava  = 11.4;                        // hlava
kl_hl_v   = 1.2;                         // válcová část hlavy
kl_hl_k   = (kl_hlava - kl_d)/2;         // kuželová část hlavy (45°)
kl_rt = 11;  kl_rw = 6;  kl_rs = 2.8;    // křídlo: délka, šířka, tloušťka
kl_pin    = 3;                           // čtyřhran pro nasazení křídla
ret_lip   = 2.5;                         // okraj štěrbiny v desce, za který se křídlo opře
kl_dutina = sqrt(kl_rt*kl_rt + kl_rw*kl_rw) + 1;
y_kridlo  = D + ret_lip - klic_predpeti; // přední plocha křídla

assert(sd >= 4 && sd <= 10, "Montážní deska musí mít 4-10 mm (vrut 5x80 musí jít aspoň 70 mm do hmoždinky 8x65).");
assert(kl_hlava + 4.6 <= tb*2 - 2*st, "Hlava klíče se nevejde do horního/dolního okraje.");
assert(tb/2 - kl_dutina/2 >= 2, "Dutina klíče v montážní desce je moc blízko okraje.");
assert(abs(roztec_sroubu - roztec_klicu)/2 >= kl_dutina/2 + hlava_sroubu/2 + 1, "Vruty do zdi a klíče jsou moc blízko u sebe.");
assert(y_kridlo + kl_rs <= D + sd - 0.3, "Křídlo klíče se nevejde do montážní desky - zvětšete tl_desky.");
assert(tistena_tl >= 0.4, "Tištěná síťka musí mít aspoň 0,4 mm (dva průjezdy).");
assert(y_rod - prumer_tycky/2 - y_bar0 >= 5, "Červík M3x5 by vyčníval z lišty a drhl o čelo rámu - posuňte y_rod dozadu.");
assert(tb >= 14, str("Okraj nahoře/dole vychází jen ", tb, " mm - zvětšete výšku nebo uberte lamely."));
assert(p*cos(phic) > t + 0.2, "Lamely by do sebe v zavřené poloze narážely - zmenšete uhel_zavreni.");
assert(sb - 2*st >= 13, "Boční okraj je příliš úzký pro komoru mechanismu.");
assert(y_ax + sqrt(L_arm*L_arm + w_arm*w_arm/4) < D - 0.3, "Rameno by drhlo o zadní desku - zvětšete hloubku.");
assert(bar_bot0 + sock_h < tz0 - 3, "Zásuvka tyčky zasahuje do západky lišty.");

// stav žaluzie
phi_open = -phic*(1 - otevreni);          // úhel lamel (0 = vodorovně)
function s_of(phi) = e*tan(phi + alpha);  // poloha lišty pro daný úhel lamel

echo(str("Průduch: ", cav_w, " x ", cav_h, " mm, zdvih táhla: ", zdvih, " mm, okraj nahoře/dole: ", tb, " mm"));

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
            for (q = klic_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) cylinder(d = kl_hlava + 4.6, h = D);
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
        // lůžko pro kupovanou síťku na zadní straně rámečku průduchu
        if (luzko_tl > 0) translate([x_cav0 - st - 0.5, D - luzko_tl, tb - st - 0.5]) cube([sit_w + 1, 1, sit_h + 1]);
        // lůžka pojistných hřebínků
        for (xs = [x_cav0 - st, x_cav1])
            translate([xs - eps, D - st, tb - st - eps]) cube([st + 2*eps, st + 1, cav_h + 2*st + 2*eps]);
        // otvory pro šrouby do zdi (zápustné)
        // otvory pro otočné klíče: zápustné lůžko hlavy v líci a průchod dříku
        for (q = klic_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) {
            translate([0, 0, -1]) cylinder(d = kl_hlava + 0.4, h = 1 + kl_hl_v);
            translate([0, 0, kl_hl_v - eps]) cylinder(d1 = kl_hlava + 0.4, d2 = kl_d + 0.4, h = kl_hl_k);
            translate([0, 0, -1]) cylinder(d = kl_d + 0.4, h = D + 2);
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
module pojistka(xs = 0) {
    tt = st - 0.2;
    translate([xs + 0.1, 0, 0]) {
        translate([0, D - st + 0.1, tb - st + 0.1]) cube([tt, st - 0.15 - luzko_tl, cav_h + 2*st - 0.2]);
        for (i = [0:N-1]) translate([0, y_ax + r_osa + 0.3, zl(i) - (r_osa + 0.05)]) {
            flen = D - st + 0.2 - (y_ax + r_osa + 0.3);
            cube([tt, flen, 2*r_osa + 0.1]);
            // přítlačná žebra: hřebínek drží v rámu natěsno i bez montážní desky (sundaný kryt)
            for (zz = [0, 2*r_osa + 0.1]) translate([tt/2, 0.5, zz]) rotate([-90, 0, 0]) cylinder(d = 0.6, h = flen - 1, $fn = 12);
        }
    }
}

// =====================================================================
//  ZADNÍ DESKA S LÍMCEM
// =====================================================================
// rozměry límce a síťky
lim_w  = limec_sirka > 0 ? limec_sirka : cav_w + 2*limec_stena;
lim_h  = limec_vyska > 0 ? limec_vyska : cav_h + 2*limec_stena;
lim_iw = min(cav_w, lim_w - 2*limec_stena);   // světlost límce
lim_ih = min(cav_h, lim_h - 2*limec_stena);
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
            if (limec) translate([W/2 - lim_w/2, D + sd - eps, H/2 - lim_h/2]) difference() {
                cube([lim_w, limec_hloubka, lim_h]);
                translate([(lim_w - lim_iw)/2, -1, (lim_h - lim_ih)/2]) cube([lim_iw, limec_hloubka + 2, lim_ih]);
            }
        }
        translate([W/2 - otv_w/2, D - 1, H/2 - otv_h/2]) cube([otv_w, sd + 2, otv_h]);
        // vruty do zdi: zápustná hlava v rovině čela desky, zakryje ji přední kryt
        for (q = screw_pos) translate([q[0], D, q[1]]) rotate([-90, 0, 0]) {
            translate([0, 0, -1]) cylinder(d = prumer_sroubu, h = sd + 2);
            translate([0, 0, -eps]) cylinder(d1 = hlava_sroubu + 0.6, d2 = prumer_sroubu, h = (hlava_sroubu + 0.6 - prumer_sroubu)/2);
        }
        // zámky klíčů: štěrbina pro křídlo (vodorovně) a za ní dutina otevřená ke zdi
        for (q = klic_pos) translate([q[0], D, q[1]]) rotate([-90, 0, 0]) {
            translate([0, 0, -1]) linear_extrude(sd + 2) offset(r = 0.3) square([kl_rt, kl_rw], center = true);
            translate([0, 0, ret_lip]) cylinder(d = kl_dutina, h = sd);
            // náběh: štěrbina se k dutině rozšiřuje, křídlo při otáčení najede na okraj
            intersection() {
                hull() {
                    translate([0, 0, ret_lip - 0.6]) linear_extrude(eps) offset(r = 0.3) square([kl_rt, kl_rw], center = true);
                    translate([0, 0, ret_lip]) linear_extrude(eps) offset(r = 0.9) square([kl_rt, kl_rw], center = true);
                }
                cylinder(d = kl_dutina, h = sd);      // náběh nesmí vyčnívat mimo dutinu (převis)
            }
        }
    }
    // pevný rošt v otvoru (podpírá síťku, zastaví ptáky)
    nx = max(1, round(otv_w/rost_roztec));
    nz = max(1, round(otv_h/rost_roztec));
    intersection() {
        translate([W/2 - otv_w/2, D, H/2 - otv_h/2]) cube([otv_w, sd, otv_h]);
        union() {
            for (i = [1:nx-1]) translate([W/2 - otv_w/2 + i*otv_w/nx - rost_zebro/2, D, 0]) cube([rost_zebro, sd, H]);
            for (k = [1:nz-1]) translate([0, D, H/2 - otv_h/2 + k*otv_h/nz - rost_zebro/2]) cube([W, sd, rost_zebro]);
        }
    }
    // tištěná síťka: první vrstvy montážní desky, deska se tiskne touto stranou dolů
    if (sitka == "tistena") translate([W/2 - otv_w/2 - 0.5, D, H/2 - otv_h/2 - 0.5]) {   // vlákna zasahují 0,5 mm do rámu
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

// otočný klíč (osa +Z, líc hlavy v z = 0); zářez na minci je rovnoběžný s křídlem
module klic() {
    difference() {
        union() {
            cylinder(d = kl_hlava, h = kl_hl_v);
            translate([0, 0, kl_hl_v - eps]) cylinder(d1 = kl_hlava, d2 = kl_d, h = kl_hl_k);
            cylinder(d = kl_d, h = y_kridlo);
            translate([-kl_pin/2, -kl_pin/2, y_kridlo - eps]) cube([kl_pin, kl_pin, kl_rs - 0.4]);   // čtyřhran pro křídlo
        }
        translate([-4, -0.8, -1]) cube([8, 1.6, 1 + 1.4]);                                            // zářez na minci
    }
}

// křídlo klíče (přední, opěrná plocha v z = 0), nasadí se na čtyřhran a přilepí
module kridlo() {
    difference() {
        hull() {
            translate([-kl_rt/2, -kl_rw/2 + 0.8, 0]) cube([kl_rt, kl_rw - 1.6, eps]);          // sražení 0,8 mm = náběh
            translate([-kl_rt/2, -kl_rw/2, 0.8]) cube([kl_rt, kl_rw, kl_rs - 0.8]);
        }
        translate([-(kl_pin + 0.15)/2, -(kl_pin + 0.15)/2, -1]) cube([kl_pin + 0.15, kl_pin + 0.15, kl_rs + 2]);
    }
}

// klíč i s křídlem na místě (zamčeno = křídlo svisle)
module klic_na_miste(q, zamceno = true) {
    translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) rotate([0, 0, zamceno ? 90 : 0]) {
        klic();
        translate([0, 0, y_kridlo]) kridlo();
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
    if (co == "zadni_deska") translate([0, H, -D]) rotate([90, 0, 0]) zadni_deska();     // límcem nahoru
    if (co == "lamela")      zrcadlo_tisk() translate([0, 0, r_osa]) lamela_local();                    // rovnou stranou dolů
    if (co == "lista")       zrcadlo_tisk() translate([0, 0, x_bar1]) rotate([0, 90, 0]) lista(0);      // čepy nahoru
    if (co == "pojistka")    rotate([0, 90, 0]) translate([-(st - 0.2) - 0.1, 0, 0]) pojistka(0);
    if (co == "rukojet")     rukojet();
    if (co == "voditko")     voditko();
    if (co == "spojka")      spojka();
    if (co == "klic")        klic();                                                     // hlavou dolů
    if (co == "kridlo_klice") translate([0, 0, kl_rs]) rotate([180, 0, 0]) kridlo();    // sražením nahoru
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
if (dil == "vymena_sitky") {   // montážní deska zůstává na zdi, přední kryt je sundaný
    s = s_of(phi_open);
    color("tan") translate([-40, D + sd, -40]) difference() {
        cube([W + 80, 4, H + 80]);
        translate([40 + W/2 - lim_w/2, -1, 40 + H/2 - lim_h/2]) cube([lim_w, 6, lim_h]);
    }
    color("gainsboro") zadni_deska();
    color("steelblue") for (q = screw_pos) translate([q[0], D + 0.01, q[1]]) rotate([90, 0, 0]) cylinder(d = hlava_sroubu, h = 0.3);
    if (sitka == "kupovana") color("dimgray", 0.8) translate([x_cav0 - st, D - luzko_tl, tb - st]) cube([sit_w - 0.5, luzko_tl, sit_h - 0.5]);
    translate([0, -90, 0]) strana() {
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
        translate([wall - 1, tb - limec_stena + 0.5 + 0]) square([200, 200]);
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
        translate([D + sd - 1, tb]) square([wall_t + 2, cav_h]);
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
    || dil == "rukojet" || dil == "voditko" || dil == "spojka" || dil == "klic" || dil == "kridlo_klice") k_tisku(dil);
