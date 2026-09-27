// =====================================================================
//  Větrací mřížka s žaluzií ovládanou svislým táhlem zespodu
//  (parametrický model pro 3D tisk, OpenSCAD 2021.01+)
//
//  Princip: vodorovné lamely se otáčejí na čepech. Na pravém konci má
//  každá lamela vidlicové rameno. Do vidlic zapadají čepy svislé
//  ovládací lišty, která jezdí jen nahoru/dolů ve skryté boční komoře.
//  Do spodku lišty se zasune tyčka (táhlo) Ø6 mm, která vede dolů
//  k ruce.  Nahoru = otevřít, dolů = zavřít.  Pružná západka na liště
//  drží polohy zavřeno / napůl / otevřeno.
//
//  Souřadnice:  X = šířka (zleva doprava při pohledu zepředu)
//               Y = hloubka (0 = přední líc, kladně směrem do zdi)
//               Z = výška
// =====================================================================

/* [Zobrazení] */
// Co vykreslit (díly "..." jsou už natočené pro tisk)
dil = "sestava"; // [sestava, rez, schema, mechanismus, rozlozeno, ram, zadni_deska, lamela, lista, pojistka, rukojet, voditko, spojka]
// Poloha žaluzie: 0 = zavřeno, 1 = otevřeno
otevreni = 1; // [0:0.05:1]
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
// Šířka bočního okraje (vpravo je v něm skrytá komora mechanismu) [mm]
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
// Síťka proti hmyzu v zadní desce
sitka = false;
sitka_oko = 3;

/* [Táhlo] */
// Průměr tyčky táhla (hliník / ocel / bukový kolík) [mm]
prumer_tycky = 6;
// Počet aretačních poloh (3 = zavřeno / půl / otevřeno)
pocet_poloh = 3;

/* [Rozteč upevňovacích šroubů] */
// Vodorovná rozteč šroubů do zdi (2 nahoře, 2 dole) [mm]
roztec_sroubu = 100;
prumer_sroubu = 4.5;

/* [Hidden] */
$fn = 48;
eps = 0.01;

W = sirka; H = vyska; D = hloubka; st = stena; sb = bok;
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
y_rod  = 10;                    // osa tyčky
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
pre_pos   = [[W/2, tb/2], [W/2, H - tb/2]];

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
            for (q = screw_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) cylinder(d = prumer_sroubu + 5.5, h = D);
            // pouzdra montážních šroubků zadní desky
            for (q = pre_pos) translate([q[0], 0, q[1]]) rotate([-90, 0, 0]) cylinder(d = 8, h = D);
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
        // lůžka pojistných hřebínků
        for (xs = [x_cav0 - st, x_cav1])
            translate([xs - eps, D - st, tb - st - eps]) cube([st + 2*eps, st + 1, cav_h + 2*st + 2*eps]);
        // otvory pro šrouby do zdi (zápustné)
        for (q = screw_pos) translate([q[0], -1, q[1]]) rotate([-90, 0, 0]) {
            cylinder(d = prumer_sroubu, h = D + 2);
            cylinder(d1 = prumer_sroubu + 5, d2 = prumer_sroubu, h = 1 + 2.5);
        }
        // předvrtání pro montážní šroubky (zezadu, nejdou skrz líc)
        for (q = pre_pos) translate([q[0], 8, q[1]]) rotate([-90, 0, 0]) cylinder(d = 2.5, h = D);
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
        translate([0, D - st + 0.1, tb - st + 0.1]) cube([tt, st - 0.15, cav_h + 2*st - 0.2]);
        for (i = [0:N-1]) translate([0, y_ax + r_osa + 0.3, zl(i) - (r_osa + 0.05)])
            cube([tt, D - st + 0.2 - (y_ax + r_osa + 0.3), 2*r_osa + 0.1]);
    }
}

// =====================================================================
//  ZADNÍ DESKA S LÍMCEM
// =====================================================================
module zadni_deska() {
    lw = limec_sirka > 0 ? limec_sirka : cav_w + 2*limec_stena;
    lh = limec_vyska > 0 ? limec_vyska : cav_h + 2*limec_stena;
    iw = min(cav_w, lw - 2*limec_stena);
    ih = min(cav_h, lh - 2*limec_stena);
    difference() {
        union() {
            translate([0, D, 0]) cube([W, st, H]);
            if (limec) translate([W/2 - lw/2, D + st - eps, H/2 - lh/2]) difference() {
                cube([lw, limec_hloubka, lh]);
                translate([(lw - iw)/2, -1, (lh - ih)/2]) cube([iw, limec_hloubka + 2, ih]);
            }
        }
        translate([x_cav0, D - 1, tb]) cube([cav_w, st + 2, cav_h]);
        for (q = screw_pos) translate([q[0], D - 1, q[1]]) rotate([-90, 0, 0]) cylinder(d = prumer_sroubu, h = st + 2);
        for (q = pre_pos) translate([q[0], D - 1, q[1]]) rotate([-90, 0, 0]) {
            cylinder(d = 3.4, h = st + 2);
            translate([0, 0, 1 + st - 1.6]) cylinder(d1 = 3.4, d2 = 6.4, h = 1.6 + eps);
        }
    }
    if (sitka) intersection() {
        translate([x_cav0, D, tb]) cube([cav_w, 1, cav_h]);
        union() {
            for (x = [x_cav0 : sitka_oko : x_cav1]) translate([x, D, tb]) cube([0.8, 1, cav_h]);
            for (z = [tb : sitka_oko : tb + cav_h]) translate([x_cav0, D, z]) cube([cav_w, 1, 0.8]);
        }
    }
}

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
    a = D + st - y_rod;           // vzdálenost osy tyčky od zdi
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
        cylinder(d = prumer_tycky + 6, h = 50, $fn = 6*8);
        translate([0, 0, -1]) cylinder(d = d_sock, h = 52);
        for (z = [10, 40]) translate([0, 0, z]) rotate([0, 90, 0]) cylinder(d = 2.5, h = 20);
    }
}

// =====================================================================
//  SESTAVY
// =====================================================================
module tycka(s) {
    color("silver") translate([x_barc, y_rod, bar_bot0 + s + 2 - nahled_delka_tycky]) cylinder(d = prumer_tycky, h = nahled_delka_tycky + sock_h - 2);
    color("dimgray") translate([x_barc, y_rod, bar_bot0 + s + 2 - nahled_delka_tycky - 20]) rotate([180, 0, 0]) translate([0, 0, -50]) rukojet();
}

module orez(k) {
    if (k) intersection() { children(); translate([-1, -1, -1]) cube([x_arm1 + 1 + eps, D + st + limec_hloubka + 2, H + 2]); }
    else children();
}

module sestava(phi, explode = 0, rez = false, tyc = true) {
    s = s_of(phi);
    color("white") orez(rez) ram();
    color("gainsboro") translate([0, 3*explode, 0]) orez(rez) zadni_deska();
    color("lightsteelblue") translate([0, 2*explode, 0]) orez(rez) for (xs = [x_cav0 - st, x_cav1]) pojistka(xs);
    color("lightgray") translate([0, explode, 0]) orez(rez) for (i = [0:N-1]) lamela_na_miste(i, phi);
    color("darkorange") translate([explode*0.4, 0, 0]) orez(rez) lista(s);
    if (tyc) tycka(s);
}

// natočení dílů pro tisk
module k_tisku(co) {
    if (co == "ram")         translate([0, H, 0]) rotate([90, 0, 0]) ram();              // lícem dolů
    if (co == "zadni_deska") translate([0, H, -D]) rotate([90, 0, 0]) zadni_deska();     // límcem nahoru
    if (co == "lamela")      translate([0, 0, r_osa]) lamela_local();                    // rovnou stranou dolů
    if (co == "lista")       translate([0, 0, x_bar1]) rotate([0, 90, 0]) lista(0);      // čepy nahoru
    if (co == "pojistka")    rotate([0, 90, 0]) translate([-(st - 0.2) - 0.1, 0, 0]) pojistka(0);
    if (co == "rukojet")     rukojet();
    if (co == "voditko")     voditko();
    if (co == "spojka")      spojka();
}

if (dil == "sestava")   sestava(phi_open);
if (dil == "rozlozeno") sestava(phi_open, 40);
if (dil == "rez")       sestava(phi_open, rez = true, tyc = false);
if (dil == "mechanismus") {   // bez zadní desky, pohled zezadu
    s = s_of(phi_open);
    color("white") ram();
    color("lightgray") for (i = [0:N-1]) lamela_na_miste(i, phi_open);
    color("darkorange") lista(s);
}
if (dil == "schema") schema(phi_open);

// 2D schéma v bočním pohledu (zleva líc, vpravo zeď): Y -> vodorovně, Z -> svisle
module vrstva(k) translate([0, 0, k]) linear_extrude(0.5) children();

module schema(phi) {
    s = s_of(phi);
    wall_t = 60;
    // zeď s otvorem
    color("tan") vrstva(0) difference() {
        translate([D + st, -60]) square([wall_t, H + 120]);
        translate([D + st - 1, tb]) square([wall_t + 2, cav_h]);
    }
    // rám v řezu komorou
    color("dimgray") vrstva(1) {
        square([st, H]);                                     // líc
        square([D, st]);                                     // dno
        translate([0, H - st]) square([D, st]);              // strop
        translate([0, bar_top0 + s_max + 0.1]) square([D, H - st - bar_top0 - s_max]);   // doraz
        difference() {                                       // zadní deska + límec
            union() {
                translate([D, 0]) square([st, H]);
                if (limec) translate([D + st, tb - limec_stena]) square([limec_hloubka, cav_h + 2*limec_stena]);
            }
            translate([D - 1, tb]) square([st + limec_hloubka + 2, cav_h]);
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
    || dil == "rukojet" || dil == "voditko" || dil == "spojka") k_tisku(dil);
