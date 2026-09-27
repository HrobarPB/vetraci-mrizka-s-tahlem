#!/usr/bin/env bash
# Vygeneruje STL díly, náhledy a animaci mechanismu a spustí kontrolu kolizí.
# Použití:  ./skripty/export.sh [další -D parametry pro OpenSCAD]
# Potřeba: openscad (2021.01+), xvfb-run (jen pro obrázky na serveru), python3 + pillow (animace)
set -euo pipefail
cd "$(dirname "$0")/.."
EXTRA=("$@")
OSC=(openscad)
if [ -z "${DISPLAY:-}" ] && command -v xvfb-run >/dev/null; then OSC=(xvfb-run -a openscad); fi

echo "== Kontrola kolizí"
out=$(openscad -o /tmp/kolize.svg "${EXTRA[@]}" kontrola.scad 2>&1 || true)
if echo "$out" | grep -q "ERROR"; then echo "$out" | grep ERROR; exit 1; fi
if [ -f /tmp/kolize.svg ]; then echo "KOLIZE! viz /tmp/kolize.svg"; exit 1; fi
echo "$out" | grep ECHO || true
echo "OK - žádné kolize v celém rozsahu pohybu"

echo "== STL"
mkdir -p stl
for d in ram zadni_deska lamela lista pojistka rukojet voditko spojka krytka ramecek_sitky sitka_tistena; do
  echo "  $d"
  openscad -o "stl/$d.stl" -D "dil=\"$d\"" "${EXTRA[@]}" mrizka.scad 2>&1 | grep -E "ERROR|WARNING" || true
done

# převod na binární STL (menší soubory), pokud je k dispozici numpy-stl
python3 - <<'PY' 2>/dev/null && echo "  STL převedena na binární" || echo "  (binární převod přeskočen: pip install numpy-stl)"
import glob
from stl import mesh, Mode
for f in glob.glob("stl/*.stl"):
    mesh.Mesh.from_file(f).save(f, mode=Mode.BINARY)
PY

echo "== Obrázky"
mkdir -p obrazky
IMG=(--colorscheme=Tomorrow --autocenter --viewall)
"${OSC[@]}" -o obrazky/sestava_otevreno.png --imgsize=1000,1200 --camera=0,0,0,78,0,-28,0 "${IMG[@]}" -D 'dil="sestava"' -D otevreni=1 "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/sestava_zavreno.png  --imgsize=1000,1200 --camera=0,0,0,78,0,-28,0 "${IMG[@]}" -D 'dil="sestava"' -D otevreni=0 "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/mechanismus.png --imgsize=1200,1000 --camera=0,0,0,60,0,150,0 "${IMG[@]}" -D 'dil="mechanismus"' -D otevreni=0.5 -D 'nahled_delka_tycky=0' "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/rozlozeno.png --imgsize=1200,1000 --camera=0,0,0,65,0,215,0 "${IMG[@]}" -D 'dil="rozlozeno"' -D otevreni=0.5 "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/detail_uchyceni.png --imgsize=2000,760 --camera=0,0,0,0,0,0,0 --projection=ortho --viewall --autocenter --colorscheme=Tomorrow -D 'dil="detail_uchyceni"' -D 'ovladani="vpravo"' "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/zezadu_sitka.png --imgsize=900,1000 --camera=0,0,0,60,0,200,0 "${IMG[@]}" -D 'dil="sestava"' -D 'nahled_delka_tycky=0' "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/rozlozeno_sitka.png --imgsize=900,1000 --camera=0,0,0,60,0,200,0 "${IMG[@]}" -D 'dil="rozlozeno"' -D 'sitka="tistena"' -D 'nahled_delka_tycky=0' "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
"${OSC[@]}" -o obrazky/lamela.png --imgsize=1200,500 --camera=0,0,0,55,0,25,0 "${IMG[@]}" -D 'dil="lamela"' "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1

python3 - <<'PY'
from PIL import Image, ImageChops
p = "obrazky/detail_uchyceni.png"
im = Image.open(p).convert("RGB")
bg = Image.new("RGB", im.size, im.getpixel((0, 0)))
x0, y0, x1, y1 = ImageChops.difference(im, bg).getbbox()
im.crop((max(x0 - 25, 0), max(y0 - 25, 0), min(x1 + 25, im.width), min(y1 + 25, im.height))).save(p)
PY

echo "== Animace mechanismu"
tmp=$(mktemp -d)
i=0
for t in $(seq 0 0.1 1) $(seq 0.9 -0.1 0.1); do
  "${OSC[@]}" -o "$tmp/f$(printf %03d $i).png" --imgsize=440,800 --camera=60,88,0,0,0,0,800 --projection=ortho \
     --colorscheme=Tomorrow -D 'dil="schema"' -D "otevreni=$t" "${EXTRA[@]}" mrizka.scad >/dev/null 2>&1
  i=$((i+1))
done
python3 - "$tmp" <<'PY'
import sys, glob
from PIL import Image
fr = [Image.open(f).convert("P", palette=Image.ADAPTIVE) for f in sorted(glob.glob(sys.argv[1] + "/f*.png"))]
d = [700] + [120]*9 + [700] + [120]*(len(fr)-11)
fr[0].save("obrazky/mechanismus.gif", save_all=True, append_images=fr[1:], duration=d, loop=0, optimize=True)
PY
rm -rf "$tmp"
echo "Hotovo."
