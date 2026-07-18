#!/usr/bin/env bash
# Ek modeller: TTS (ses) + video (AnimateDiff) indirir (HuggingFace)
PY="/c/pinokio/bin/miniconda/python.exe"
BASE="/c/Users/alici/cartoon-factory/models"
mkdir -p "$BASE/tts" "$BASE/video"

echo "[1/2] TTS modeli (Coqui XTTS v2) indiriliyor..."
"$PY" -c "
from huggingface_hub import snapshot_download
snapshot_download(repo_id='coqui/XTTS-v2', local_dir='$BASE/tts/xtts', local_dir_use_symlinks=False)
print('TTS TAMAM')
" 2>&1 | tail -3

echo "[2/2] AnimateDiff (video) indiriliyor..."
"$PY" -c "
from huggingface_hub import hf_hub_download
hf_hub_download(repo_id='guoyww/animatediff-motion-adapter', filename='v3_sd15_mm.ckpt', local_dir='$BASE/video')
print('ANIMATEDIFF TAMAM')
" 2>&1 | tail -3
echo "DONE"
