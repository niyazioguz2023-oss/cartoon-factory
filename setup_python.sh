#!/usr/bin/env bash
# Python 3.11 kurulumu (ComfyUI icin) - RTX 3050 / Windows 11
# Bu script Python'u indirir ve sessiz kurar.
set -uo pipefail
PYVER="3.11.9"
URL="https://www.python.org/ftp/python/3.11.9/python-3.11.9-amd64.exe"
INSTALLER="$TEMP/python_installer.exe"
echo "Indiriliyor: $URL"
curl -s -L --max-time 300 -o "$INSTALLER" "$URL" || { echo "INDIRME HATASI"; exit 1; }
echo "Kuruluyor (silent)..."
"$INSTALLER" /quiet InstallAllUsers=0 PrependPath=1 Include_pip=1 Include_launcher=1 || { echo "KURULUM HATASI"; exit 1; }
echo "Python kuruldu. Dogrula:"
"$LOCALAPPDATA/Programs/Python/Python311/python.exe" --version
