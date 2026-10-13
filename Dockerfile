FROM python:3.10-slim

WORKDIR /app

# 1. Instala dependências e utilitários de sistema obrigatórios
RUN apt-get update && apt-get install -y curl git && rm -rf /var/lib/apt/lists/*

# 2. Instala pacotes Python e garante atualização do gerenciador de pacotes
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir kaggle pyyaml

# 3. Mapeia o binário global do Kaggle para que o interpretador o localize como comando nativo
RUN ln -s /usr/local/bin/kaggle /usr/local/bin/pip-kaggle || true

# 4. Baixa o código fonte diretamente do pacote compactado na rota estável (sem falha de tar)
RUN curl -L https://github.com | tar -xz --strip-components=1 -C /app

# 5. Importa o script de entrada e aplica permissões de leitura e execução
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
