#!/bin/bash

# Cria o diretório de credenciais do Kaggle
mkdir -p ~/.kaggle

# Injeta as variáveis de ambiente fornecidas pelo Coolify no formato JSON exigido
echo "{\"username\":\"${KAGGLE_USERNAME}\",\"key\":\"${KAGGLE_KEY}\"}" > ~/.kaggle/kaggle.json
chmod 600 ~/.kaggle/kaggle.json

# Dispara o inicializador oficial do repositório
echo "Iniciando controle remoto da TPU no Kaggle..."
exec python launch.py serve
