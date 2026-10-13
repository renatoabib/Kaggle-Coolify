FROM python:3.10-slim

WORKDIR /app

# 1. Instala dependências básicas do sistema
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# 2. Instala as bibliotecas Python necessárias
RUN pip install --no-cache-dir kaggle pyyaml

# 3. Cria um link simbólico para corrigir o erro do módulo do Kaggle
RUN ln -s /usr/local/bin/kaggle /usr/local/bin/pip-kaggle || true

# 4. Baixa e extrai o código do repositório da TPU na pasta /app
RUN curl -L https://github.com/ARahim3/kaggle-tpu-lab | tar -xz --strip-components=1 -C /app

# 5. Copia o seu script de inicialização local
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
