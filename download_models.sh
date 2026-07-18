#!/usr/bin/env bash
# HuggingFace'ten SD modellerini indirir (Pinokio conda python ile)
PY="/c/pinokio/bin/miniconda/python.exe"
BASE="/c/Users/alici/cartoon-factory/models"
mkdir -p "$BASE/sd15" "$BASE/sdxl"

echo "[1/2] SD 1.5 indiriliyor (~4GB)..."
"$PY" -c "
from huggingface_hub import snapshot_download
snapshot_download(repo_id='runwayml/stable-diffusion-v1-5', local_dir='$BASE/sd15', local_dir_use_symlinks=False)
print('SD1.5 TAMAM')
"
echo "[2/2] SDXL base indiriliyor (~5GB, arka plan yok burada)..."
"$PY" -c "
from huggingface_hub import snapshot_download
snapshot_download(repo_id='stabilityai/stable-diffusion-xl-base-1.0', local_dir='$BASE/sdxl', local_dir_use_symlinks=False)
print('SDXL TAMAM')
"
echo "DONE"
