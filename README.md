ÇİZGİ FİLM FABRİKASI (cartoon-factory)
=======================================
NVIDIA API (bulut, metin/senaryo) + yerel SD (ComfyUI/RTX 3050, görsel) ile
Instagram / YouTube için tutarlı karakterli çizgi film + sosyal medya içeriği.

BİLGİSAYAR: i7-12700H / 16GB RAM / RTX 3050 4GB / Windows 11
NVIDIA HESAP: 4x nvapi anahtar (aynı hesap) → metin/vision/guard/reason/pii
GÖRSEL ÜRETİM: Yerel ComfyUI + SD 1.5/SDXL (RTX 3050, bulut key gerekmez)

══════════════════════════════════════════════
KURULUM
══════════════════════════════════════════════
1) NVIDIA anahtarları:
   nvidia-ai/.env, .env2, .env3, .env4  → NVIDIA_API_KEY[_2,_3,_4]
   (Bu hesapta text-to-image YOK — görsel yerel ComfyUI'den)

2) Görsel üretim (yerel, Pinokio conda ile):
   bash download_models.sh          # SD 1.5 + SDXL indirir (HuggingFace)
   bash setup_comfyui_pinokio.sh     # ComfyUI + torch (CUDA 12.1) kurar

3) ComfyUI'yi başlat:
   bash start_comfyui.sh             # http://127.0.0.1:8188

══════════════════════════════════════════════
KULLANIM
══════════════════════════════════════════════
# 1) Karakter oluştur (tutarlı karakter sheet)
./cartoon-character.sh "macera seven kucuk kahverengi kedi, gozluklü" character.md

# 2) YouTube 5-10 dk uzun metraj senaryo + görsel prompt
./cartoon-youtube.sh character.md "kedi uzayda kayboluyor" 5 youtube.md

# 3) Instagram görselleri (post/carousel/story) + caption
./cartoon-instagram.sh character.md carousel "kedi ilk okul gunu" insta.md

# 4) Görsel üret (ComfyUI çalışırken)
python render_api.py "a cute cartoon cat wearing red hat, flat vector" out.png sd15

══════════════════════════════════════════════
DOSYALAR
══════════════════════════════════════════════
lib.sh                  → NVIDIA API çağrısı (3 anahtar, rate-limit yönetimi)
cartoon-character.sh    → Tutarlı karakter sheet
cartoon-episode.sh      → Kısa bölüm (Reels/Shorts)
cartoon-youtube.sh      → 5-10 dk uzun metraj senaryo + sahne planı
cartoon-instagram.sh    → Instagram post/carousel/story + caption
cartoon-render.sh       → Sahne prompt'larını görsele çevirir (ComfyUI)
render_api.py           → ComfyUI API ile yerel SD render
start_comfyui.sh        → ComfyUI'yi RTX 3050 için başlatır
download_models.sh      → HuggingFace'ten SD modeli indirir
setup_comfyui_pinokio.sh→ ComfyUI + torch kurar

══════════════════════════════════════════════
NVIDIA MODEL ENVANTERİ (bu hesapta çalışan ~49 model)
══════════════════════════════════════════════
Metin LLM: Nemotron Super 49B, Ultra 550B, Llama-3.3, DeepSeek-v4, Mistral, Qwen
Vision (analiz): nemotron-nano-vl 8B/12B, llama-3.2-vision 11B/90B
Guard: Nemotron content-safety, GLiNER-PII, Nemoguard, Llama-Guard
Reasoning: Nemotron omni-reasoning
❌ Text-to-image: YOK (hesap kısıtı → yerel ComfyUI kullanılır)

Repo: https://github.com/niyazioguz2023-oss/cartoon-factory
