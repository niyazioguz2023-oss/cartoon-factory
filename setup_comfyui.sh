#!/usr/bin/env bash
# setup_comfyui.ps1 tabanli kurulum caller (bash wrapper)
# Gercek isi powershell yapacak (curl MSYS'de sorunlu)
powershell -NoProfile -ExecutionPolicy Bypass -File "$(dirname "$0")/setup_comfyui.ps1"
