#!/usr/bin/env bash
set -Eeuo pipefail

# Los repositorios originales solo se consultan. Este script escribe
# exclusivamente dentro del repositorio comunimap-local.
if [[ "$(basename "$(git rev-parse --show-toplevel)")" != "comunimap-local" ]]; then
  echo "ERROR: ejecutar únicamente en comunimap-local" >&2
  exit 1
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

echo "Descargando originales en modo lectura..."
git clone --depth 1 https://github.com/JFCXD/comunimap.git "$tmp/origen-web"
git clone --depth 1 https://github.com/JFCXD/comunimap-api.git "$tmp/origen-api"
git clone --depth 1 https://github.com/JFCXD/app-comunimap.git "$tmp/origen-android"

mkdir -p web api android
# Excluir archivos de entorno reales, credenciales privadas y directorios Git.
# Se conserva .env.example para configurar la instalación local.
rsync -a --delete --exclude='.git/' --exclude='.env' --exclude='*.pem' --exclude='*.key' --exclude='service-account*.json'   "$tmp/origen-web/GestionDeAlertas/" web/
# Conservar también el archivo de respaldo incluido en el repositorio original.
if [[ -f "$tmp/origen-web/GestionDeAlertas.zip" ]]; then
  cp "$tmp/origen-web/GestionDeAlertas.zip" web/GestionDeAlertas.zip
fi

rsync -a --delete --exclude='.git/' --exclude='.env' --exclude='*.pem' --exclude='*.key' --exclude='service-account*.json'   "$tmp/origen-api/" api/
rsync -a --delete --exclude='.git/' --exclude='.env' --exclude='*.pem' --exclude='*.key' --exclude='service-account*.json'   "$tmp/origen-android/comunimap/" android/
if [[ -d "$tmp/origen-android/respaldo_anterior" ]]; then
  rsync -a --delete --exclude='.git/' --exclude='.env' --exclude='*.pem' --exclude='*.key' --exclude='service-account*.json'     "$tmp/origen-android/respaldo_anterior/" android/respaldo_anterior/
fi

echo "Copia preparada dentro de web/, api/ y android/."
