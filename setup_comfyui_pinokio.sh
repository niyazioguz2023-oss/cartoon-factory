#!/usr/bin/env bash
# ComfyUI kurulumu (Pinokio conda python ile, RTX 3050 4GB)
PY="/c/pinokio/bin/miniconda/python.exe"
PIP="/c/pinokio/bin/miniconda/Scripts/pip.exe"
BASE="/c/Users/alici/cartoon-factory/comfyui"
mkdir -p "$BASE"; cd "$BASE"

echo "[1/3] ComfyUI indiriliyor..."
"$PY" -c "import urllib.request,zipfile; urllib.request.urlretrieve('https://github.com/comfyanonymous/ComfyUI/archive/refs/heads/master.zip','comfyui.zip'); zipfile.ZipFile('comfyui.zip').extractall('.'); import os; os.rename('ComfyUI-master','ComfyUI')"
echo "indirildi."

echo "[2/3] Torch (CUDA 12.1, RTX 3050) kuruluyor..."
"$PIP" install --quiet torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

echo "[3/3] Gereksinimler kuruluyor..."
cd ComfyUI && "$PIP" install --quiet -r requirements.txt

echo "KURULUM TAMAM"
