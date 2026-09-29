// Kontrola kolizí mechanismu v celém rozsahu pohybu (2D řezy).
// Výsledek musí být PRÁZDNÝ ("Current top level object is empty").
// Spuštění:  openscad -o kolize.svg kontrola.scad
include <mrizka.scad>
dil = "nic";
kroky = 40;
big = 1000;

module lamely2d(phi) for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) lamela_profil();
module ramena2d(phi) for (i = [0:N-1]) translate([y_ax, zl(i)]) rotate(phi) rameno_profil();
module cepy2d(s) for (i = [0:N-1]) translate([y_pin, zl(i) + s]) circle(r = r_cep);

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

// vačka a držák jejího horního čepu (pevné, v řezu komorou)
module vacka2d() translate([vk_y, 0]) {      // kotouč dorazu (plný až do výšky stěny) a horní čep
    translate([-vk_r, st]) square([2*vk_r, vk_W - st]);
    translate([-vk_hr, vk_W]) square([2*vk_hr, vk_hl]);
}
module drzak2d() translate([st - eps, drz_z0]) square([drz_y1 - st + eps, drz_z2 - drz_z0]);
module lista2d(s) translate([y_bar0, bar_bot0 + s]) difference() {
    square([y_bar1 - y_bar0, bar_top0 - bar_bot0]);
    translate([-1, -1]) square([kz_y0 - y_bar0 + 1, lista_vybrani + 1]);
}

for (k = [0:kroky]) {
    phi = -phic*(1 - k/kroky);
    s = s_of(phi);
    translate([k*200, 0]) {
        intersection() { lamely2d(phi); steny_A(); }
        for (i = [0:N-2]) intersection() {
            translate([y_ax, zl(i)])   rotate(phi) lamela_profil();
            translate([y_ax, zl(i+1)]) rotate(phi) lamela_profil();
        }
        intersection() { ramena2d(phi); union() { steny_B(); vacka2d(); drzak2d(); } }
        intersection() { ramena2d(phi); cepy2d(s); }
        for (i = [0:N-2]) intersection() {
            translate([y_ax, zl(i)])   rotate(phi) rameno_profil();
            translate([y_ax, zl(i+1)]) rotate(phi) rameno_profil();
        }
        // lišta v komoře: stěny, horní doraz, vačka, držák čepu vačky
        intersection() {
            lista2d(s);
            union() { steny_B(); vacka2d(); drzak2d(); translate([-big/2, bar_top0 + s_max + 0.1 + eps]) square([big, big]); }
        }
        // čep musí zůstat v rovné části vidlice (ne v rozšířeném ústí)
        if (e/cos(phi + alpha) > L_arm - usti_l - 0.3) square(5);
    }
}
