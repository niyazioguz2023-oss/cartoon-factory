#!/usr/bin/env bash
# studio.sh — cok modullu AI medya stüdyosu (tek giris noktasi)
# Moduller: text (NVIDIA), image (ComfyUI), audio (TTS), video, social
# Kullanim: ./studio.sh <modul> <alt-komut> [args...]
set -uo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
source "$ROOT/lib.sh"

MODULE="${1:-help}"; shift || true
case "$MODULE" in
  text)
    # NVIDIA tabanli metin islemleri
    SUB="${1:-chat}"; shift || true
    case "$SUB" in
      chat)   nvidia_chat "$1" ;;
      char)   bash "$ROOT/cartoon-character.sh" "$@" ;;
      yt)     bash "$ROOT/cartoon-youtube.sh" "$@" ;;
      ig)     bash "$ROOT/cartoon-instagram.sh" "$@" ;;
      ep)     bash "$ROOT/cartoon-episode.sh" "$@" ;;
      *) echo "text alt-komutlari: chat, char, yt, ig, ep" ;;
    esac ;;
  image)
    SUB="${1:-render}"; shift || true
    case "$SUB" in
      render) PY="/c/pinokio/bin/miniconda/python.exe"; "$PY" "$ROOT/render_api.py" "$@" ;;
      start)  bash "$ROOT/start_comfyui.sh" ;;
      *) echo "image alt-komutlari: render, start" ;;
    esac ;;
  audio)
    echo "[audio] TTS modulu hazirlaniyor (Pinokio/Riva veya bulut TTS) — yakinda" ;;
  video)
    echo "[video] video modulu hazirlaniyor (AnimateDiff/SVD yerel) — yakinda" ;;
  social)
    echo "[social] sosyal medya paketleme hazirlaniyor — yakinda" ;;
  help|*)
    cat <<'EOF'
ÇOK MODÜLLÜ AI MEDYA STÜDYOSU
===========================
Moduller:
  text   → NVIDIA API: chat, char (karakter), yt (YouTube 5-10dk), ig (Instagram), ep (bolum)
  image  → ComfyUI/SD: render <prompt> <out.png> [sd15|sdxl], start (ComfyUI baslat)
  audio  → TTS (hazirlaniyor)
  video  → goruntu->video (hazirlaniyor)
  social → otomatik paketleme (hazirlaniyor)

Ornek:
  ./studio.sh text yt character.md "kedi uzayda" 5 youtube.md
  ./studio.sh image start
  ./studio.sh image render "cute cartoon cat" out.png sd15
EOF
    ;;
esac
