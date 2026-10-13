#!/bin/bash
# Cria o diretório de credenciais
mkdir -p ~/.kaggle

# Injeta as chaves do Coolify no arquivo JSON
echo "{\"username\":\"${KAGGLE_USERNAME}\",\"key\":\"${KAGGLE_KEY}\"}" > ~/.kaggle/kaggle.json
chmod 600 ~/.kaggle/kaggle.json

# Adiciona o caminho dos binários do Python ao PATH do sistema
export PATH="/usr/local/bin:$PATH"

echo "Iniciando controle remoto da TPU no Kaggle..."
# Executa o launch.py
exec python launch.py serve
