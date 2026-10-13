#!/bin/bash
set -e

# Estrutura o diretório padrão e gera o arquivo JSON de autenticação
mkdir -p ~/.kaggle
echo "{\"username\":\"${KAGGLE_USERNAME}\",\"key\":\"${KAGGLE_KEY}\"}" > ~/.kaggle/kaggle.json
chmod 600 ~/.kaggle/kaggle.json

# Exporta os caminhos de binários locais para o escopo global do contêiner
export PATH="/usr/local/bin:$PATH"

echo "Iniciando controle remoto da TPU no Kaggle..."
# Executa o script orquestrador da TPU v5e
exec python launch.py serve
