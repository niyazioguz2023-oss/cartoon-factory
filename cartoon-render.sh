#!/usr/bin/env bash
# cartoon-render.sh — Episode/YouTube senaryosundaki gorsel prompt'lari BULUT'ta render eder.
# Backend ONCELIK: NVIDIA nvcf SDXL (bu hesapta yoksa) -> Stability AI API (SDXL).
# PC gerektirmez. NVIDIA anahtari gorsel uretemez, bu yuzden Stability AI kullanilir.
#
# Kullanim: ./cartoon-render.sh <senaryo.md> [cikti_klasoru]
source "$(dirname "$0")/lib.sh"

SCRIPT_IN="${1:?Senaryo dosyasi gerekli}"
OUTDIR="${2:-renders}"
mkdir -p "$OUTDIR"

# Anahtarlar
NVIDIA2="$(grep -E '^export NVIDIA_API_KEY_2=' "$(dirname "$0")/../nvidia-ai/.env2" 2>/dev/null | head -1 | cut -d'"' -f2)"
STABILITY="${STABILITY_TOKEN:-}"

# Gorsel prompt'lari cikar (satir icindeki "GORSEL PROMPT (INGILIZCE): ..." veya "INGILIZCE): ...")
prompts=$(grep -oE 'GORSEL PROMPT \(INGILIZCE\):?.{0,900}' "$SCRIPT_IN" | sed -E 's/GORSEL PROMPT \(INGILIZCE\)?:?//' | sed 's/"//g' | grep -v '^$')

i=1
echo "$prompts" | while IFS= read -r p; do
  [ -z "$p" ] && continue
  outfile="$OUTDIR/scene_$(printf '%02d' $i).png"
  echo "=== Sahne $i render -> $outfile ==="
  echo "$p" | head -c 90; echo

  rendered=0
  # [1] NVIDIA nvcf SDXL (genelde bu hesapta yok -> atlanir)
  if [ -n "$NVIDIA2" ]; then
    code=$(curl -s --max-time 90 -o "$outfile" -w "%{http_code}" \
      "https://ai.api.nvidia.com/v1/genai/stabilityai/stable-diffusion-xl" \
      -H "Authorization: Bearer $NVIDIA2" -H "Content-Type: application/json" \
      -d "{\"text_prompts\":[{\"text\":\"$p, high quality flat vector cartoon, clean lines\",\"weight\":1}],\"cfg_scale\":5,\"steps\":30,\"width\":1024,\"height\":1024,\"samples\":1}" 2>/dev/null)
    if [ "$code" = "200" ] && file "$outfile" 2>/dev/null | grep -q 'PNG image'; then
      echo "  NVIDIA SDXL ile uretildi."; rendered=1
    else
      rm -f "$outfile"
    fi
  fi
  # [2] Stability AI API (SDXL, bulut)
  if [ $rendered -eq 0 ] && [ -n "$STABILITY" ]; then
    curl -s --max-time 90 -o "$outfile" \
      "https://api.stability.ai/v1/generation/stable-diffusion-xl-1024-v1-0/text-to-image" \
      -H "Authorization: Bearer $STABILITY" -H "Content-Type: application/json" \
      -d "{\"text_prompts\":[{\"text\":\"$p, high quality flat vector cartoon, clean lines\",\"weight\":1}],\"width\":1024,\"height\":1024,\"steps\":30,\"cfg_scale\":5,\"samples\":1}" 2>/dev/null
    # Stability base64 JSON dondurur -> png'ye cevir
    if [ -s "$outfile" ]; then
      b64=$(grep -oE '"image":"[^"]*"' "$outfile" | head -1 | sed 's/"image":"//;s/"$//')
      if [ -n "$b64" ]; then
        printf '%s' "$b64" | base64 -d > "$outfile.png" 2>/dev/null && mv "$outfile.png" "$outfile"
        echo "  Stability AI ile uretildi."; rendered=1
      else
        rm -f "$outfile"
      fi
    fi
  fi
  if [ $rendered -eq 0 ]; then
    echo "  GORSEL URETILEMEDI (ne NVIDIA ne Stability erisilebilir). Prompt dosyada kaldi."
    echo "$p" > "$OUTDIR/scene_$(printf '%02d' $i).prompt.txt"
  fi
  i=$((i+1))
done
echo "Render tamam. Ciktilar: $OUTDIR/"
