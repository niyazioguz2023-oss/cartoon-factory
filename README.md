ÇİZGİ FİLM FABRİKASI (cartoon-factory)
=======================================
NVIDIA API (bulut, metin/prompt) + RTX 3050 (yerel, görsel render) ile
Instagram / YouTube için tutarlı karakterli çizgi film üretim pipeline'ı.

BİLGİSAYAR: i7-12700H / 16GB / RTX 3050 4GB / Windows 11

MİMARİ
------
  [1] NVIDIA API  --> Karakter tanımı (character sheet)
  [2] NVIDIA API  --> Bölüm senaryosu + her sahne için görsel PROMPT
  [3] RTX 3050    --> ComfyUI + SD 1.5 ile görsel render (karakter sabit)
  [4] Sosyal medya paketi (caption/hashtag/title) --> NVIDIA'dan gelir

KULLANIM
--------
  1) Karakter oluştur:
     ./cartoon-character.sh "fikir" character_sheet.md
     -> Tutarlı fiziksel özellikler + HEX renk paleti + İngilizce referans prompt

  2) Bölüm üret:
     ./cartoon-episode.sh character_sheet.md "bölüm fikri" bolum.md
     -> 3-5 sahne, her biri için görsel prompt (karakter SABİT), sosyal medya paketi

  3) Görsel render (RTX 3050, ComfyUI kurulu olmalı):
     ./setup_comfyui.sh        # ilk kez: ComfyUI + SD1.5 kurar
     ./start_comfyui.sh        # ComfyUI'yi başlatır (http://127.0.0.1:8188)
     ./cartoon-render.sh bolum.md renders/   # prompt'ları render eder

KARAKTER DEVAMLILIĞI NASIL SAĞLANIYOR?
--------------------------------------
  NVIDIA, character sheet'te fiziksel özellikleri ve HEX renk kodlarını net
  tanımlar. Her sahne prompt'u bu özellikleri birebir tekrar eder
  ("consistent character design, [özellikler], [renkler]"). Stable Diffusion
  aynı referans prompt'u aldığı için karakter görsel olarak sabit kalır.
  (İleri seviye için: karakter LoRA eğitimi eklenebilir.)

DOSYALAR
--------
  lib.sh              -> ortak NVIDIA chat fonksiyonu
  cartoon-character.sh -> karakter sheet üretir
  cartoon-episode.sh   -> senaryo + görsel prompt + sosyal medya paketi
  cartoon-render.sh    -> ComfyUI'ye render isteği gönderir
  setup_python.sh      -> Python 3.11 kurar (ComfyUI için)
  setup_comfyui.sh     -> ComfyUI + SD 1.5 kurar

NOT: Görsel üretim NVIDIA API'de yok; bu yüzden yerel RTX 3050 kullanılır.
NVIDIA sadece metin/prompt ve sosyal medya metinleri üretir.
