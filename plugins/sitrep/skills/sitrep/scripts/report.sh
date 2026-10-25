#!/bin/sh
# Manage the temporary directory that holds a sitrep HTML report.
#   report.sh new          create a fresh temp dir with index.html, print its path
#   report.sh clean <dir>  delete a directory created by `new`
set -eu

PREFIX="sitrep."
BASE="${TMPDIR:-/tmp}"
BASE="${BASE%/}"
HERE="$(cd "$(dirname "$0")" && pwd)"

case "${1:-}" in
  new)
    # Sweep leftovers from earlier sessions (older than a day); only our own prefix.
    find "$BASE" -maxdepth 1 -type d -name "${PREFIX}*" -mtime +1 -exec rm -rf {} + 2>/dev/null || true
    dir="$(mktemp -d "$BASE/${PREFIX}XXXXXX")"
    cp "$HERE/../template.html" "$dir/index.html"
    echo "$dir"
    ;;
  clean)
    dir="${2:?usage: report.sh clean <dir>}"
    # Refuse anything that is not a real directory directly under BASE with our prefix.
    if [ -L "$dir" ] || [ ! -d "$dir" ] || [ "$(dirname "$dir")" != "$BASE" ]; then
      echo "refusing to delete: $dir" >&2; exit 1
    fi
    case "$(basename "$dir")" in
      "${PREFIX}"*) rm -rf "$dir"; echo "deleted $dir" ;;
      *) echo "refusing to delete: $dir" >&2; exit 1 ;;
    esac
    ;;
  *)
    echo "usage: report.sh new | clean <dir>" >&2; exit 2
    ;;
esac
