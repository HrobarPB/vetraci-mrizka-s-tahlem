// Kontrola kolizí mechanismu v celém rozsahu pohybu (2D řezy).
// Výsledek musí být PRÁZDNÝ ("Current top level object is empty").
// Spuštění:  openscad -o kolize.svg kontrola.scad
include <mrizka.scad>
dil = "nic";
kroky = 40;
big = 1000;

module lamely2d(phi) for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) lamela_profil();
module ramena2d(phi) for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) rameno_profil();
module cepy2d(phi)   for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) cep_na_rameni();

// stěny v řezu průduchem: horní a dolní okraj (vepředu je okno, vzadu otvor)
module steny_A() {
    translate([-big/2, -big]) square([big, big + tb - eps]);
    translate([-big/2, H - tb + eps]) square([big, big]);
    translate([-big, -big/2]) square([big + 0 - eps, 2*big]);          // před lícem (y < 0)
    translate([D + sd + limec_hloubka + eps, -big/2]) square([big, 2*big]);
}
// stěny v řezu ramen: čelo, zadní deska, dno, strop komory
module steny_B() {
    translate([-big, -big/2]) square([big + st - eps, 2*big]);
    translate([D + eps, -big/2]) square([big, 2*big]);
    translate([-big/2, -big]) square([big, big + st - eps]);
    translate([-big/2, H - st + eps]) square([big, big]);
}
// lišta v řezu v rovině čepů (x mezi lícem lišty a dnem drážek): plná kromě drážek
module lista_cepy2d(s) translate([0, s]) difference() {
    translate([y_bar0, bar_bot0]) square([y_bar1 - y_bar0, bar_top0 - bar_bot0]);
    for (i = [0:N-1]) translate([0, zl(i)]) drazka_profil();
}
// spodní blok lišty (přes celou šířku komory, tedy i v rovině ramen)
module blok2d(s) translate([y_bar0, bar_bot0 + s]) square([y_bar1 - y_bar0, h_blok]);
// podložka a matice na dně komory (otáčí se s tyčí)
module matice_dno2d() translate([y_rod - podl_d/2, st - eps]) square([podl_d, z_nyl - st]);

for (k = [0:kroky]) {
    phi = -phic*(1 - k/kroky);
    s = s_of(phi);
    translate([k*200, 0]) {
        intersection() { lamely2d(phi); steny_A(); }
        for (i = [0:N-2]) intersection() {
            translate([y_ax, zl(i)])   rotate(phi) lamela_profil();
            translate([y_ax, zl(i+1)]) rotate(phi) lamela_profil();
        }
        intersection() { ramena2d(phi); steny_B(); }
        for (i = [0:N-2]) intersection() {
            translate([y_ax, zl(i)])   rotate(phi) rameno_profil();
            translate([y_ax, zl(i+1)]) rotate(phi) rameno_profil();
        }
        // čepy musí zůstat v drážkách lišty
        intersection() { cepy2d(phi); lista_cepy2d(s); }
        // ramena ani čepy nesmí narazit na spodní blok lišty
        intersection() { union() { ramena2d(phi); cepy2d(phi); } blok2d(s); }
        // lišta v komoře: nesmí do stěn, do horního dorazu ani do matice na dně
        intersection() {
            translate([y_bar0, bar_bot0 + s]) square([y_bar1 - y_bar0, bar_top0 - bar_bot0]);
            union() { steny_B(); matice_dno2d(); translate([-big/2, bar_top0 + s_max + 0.1 + eps]) square([big, big]); }
        }
    }
}
