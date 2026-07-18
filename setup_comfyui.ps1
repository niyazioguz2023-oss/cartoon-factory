# ComfyUI + SD 1.5 kurulumu (RTX 3050 4GB) - PowerShell
# Python 3.11 kurulu olmali.
$ErrorActionPreference = "Stop"
$PyDir = "$env:LOCALAPPDATA\Programs\Python\Python311"
$Py = "$PyDir\python.exe"
$Pip = "$PyDir\Scripts\pip.exe"
$Base = "$env:USERPROFILE\cartoon-factory\comfyui"
New-Item -ItemType Directory -Force -Path $Base | Out-Null
Set-Location $Base

Write-Host "[1/4] ComfyUI indiriliyor..."
Invoke-WebRequest -Uri "https://github.com/comfyanonymous/ComfyUI/archive/refs/heads/master.zip" -OutFile "comfyui.zip" -TimeoutSec 180
Expand-Archive -Path "comfyui.zip" -DestinationPath "." -Force
if (Test-Path "ComfyUI-master") { Move-Item -Force "ComfyUI-master" "ComfyUI" }

Write-Host "[2/4] Torch (CUDA 12.1) kuruluyor (bu uzun surer)..."
& $Pip install --quiet torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

Write-Host "[3/4] Gereksinimler kuruluyor..."
Set-Location "$Base\ComfyUI"
& $Pip install --quiet -r requirements.txt

Write-Host "[4/4] SD 1.5 model indiriliyor..."
New-Item -ItemType Directory -Force -Path "models\checkpoints" | Out-Null
Invoke-WebRequest -Uri "https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors" -OutFile "models\checkpoints\sd1.5_cartoon.safetensors" -TimeoutSec 600

# Baslatma scripti
@"
@echo off
call "$PyDir\python.exe" main.py --listen 127.0.0.1 --port 8188
"@ | Out-File -Encoding ascii "$Base\start.bat"

Write-Host "KURULUM TAMAM. Baslat: $Base\start.bat"
