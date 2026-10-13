FROM python:3.10-slim

WORKDIR /app

# 1. Instala dependências básicas do sistema
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. Instala as bibliotecas Python necessárias
RUN pip install --no-cache-dir kaggle pyyaml

# 3. Cria o link simbólico para a CLI do Kaggle
RUN ln -s /usr/local/bin/kaggle /usr/local/bin/pip-kaggle || true

# 4. O próprio Docker baixa e extrai o repositório na pasta /app de forma nativa e segura
ADD https://github.com/ARahim3/kaggle-tpu-lab /tmp/
RUN tar -xzf /tmp/main.tar.gz --strip-components=1 -C /app && rm /tmp/main.tar.gz

# 5. Copia o seu script de inicialização local
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
