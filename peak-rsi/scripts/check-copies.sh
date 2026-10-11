#!/bin/sh
# Fails if the GitHub root copies drift from the skill folder, or the zip does.
# Run from anywhere. The script lives at <repo>/scripts/ or <skill>/scripts/.
set -eu

HERE=$(CDPATH= cd -- "$(dirname "$0")" && pwd)
if [ -f "$HERE/../peak-rsi/SKILL.md" ]; then
  ROOT=$(CDPATH= cd -- "$HERE/.." && pwd)
  SKILL="$ROOT/peak-rsi"
elif [ -f "$HERE/../SKILL.md" ]; then
  SKILL=$(CDPATH= cd -- "$HERE/.." && pwd)
  ROOT=$(CDPATH= cd -- "$SKILL/.." && pwd)
else
  echo "cannot find skill root from $HERE" >&2
  exit 1
fi

cmp "$ROOT/README.md" "$SKILL/README.md"
cmp "$ROOT/install.sh" "$SKILL/install.sh"

python3 - "$ROOT" "$SKILL" <<'PY'
import hashlib, sys, zipfile
from pathlib import Path
root, skill = Path(sys.argv[1]), Path(sys.argv[2])
zpath = root / "dist" / "peak-rsi.zip"
if not zpath.is_file():
    sys.exit("missing " + str(zpath))
z = zipfile.ZipFile(zpath)
expected = []
for p in sorted(skill.rglob("*")):
    if p.is_file():
        expected.append("peak-rsi/" + p.relative_to(skill).as_posix())
got = [n for n in z.namelist() if not n.endswith("/")]
if sorted(got) != sorted(expected):
    sys.exit("zip entries differ\n missing %s\n extra %s" % (
        sorted(set(expected) - set(got)), sorted(set(got) - set(expected))))
for name in expected:
    disk = skill / name[len("peak-rsi/"):]
    if hashlib.sha256(disk.read_bytes()).digest() != hashlib.sha256(z.read(name)).digest():
        sys.exit("zip bytes differ: " + name)
print("copies and zip match", len(expected), "files")
PY
