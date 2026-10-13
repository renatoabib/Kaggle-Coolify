FROM python:3.10-slim

WORKDIR /app

# 1. Instala dependências básicas do sistema
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. Instala as bibliotecas Python necessárias
RUN pip install --no-cache-dir kaggle pyyaml

# 3. Clona o repositório correto da TPU e distribui os arquivos
RUN git clone https://github.com /tmp/tpu-lab \
    && cp -r /tmp/tpu-lab/* /app/ \
    && rm -rf /tmp/tpu-lab

# 4. Copia o seu script de inicialização local
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
