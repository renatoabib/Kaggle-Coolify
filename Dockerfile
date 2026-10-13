FROM python:3.10-slim

WORKDIR /app

# Instala dependências básicas e a CLI do Kaggle
RUN apt-get update && apt-get install -y git && rm -rf /lib/apt/lists/*
RUN pip install --no-cache-dir kaggle pyyaml

# Copia os arquivos do projeto original
RUN git clone https://github.com .

# Copia o script de inicialização customizado para o Coolify
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
