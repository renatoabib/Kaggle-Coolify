FROM python:3.10-slim

WORKDIR /app

# 1. Instala dependências básicas do sistema e remove arquivos residuais
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# 2. Instala as bibliotecas Python necessárias
RUN pip install --no-cache-dir kaggle pyyaml

# 3. Clona o repositório da TPU especificando a URL CORRETA de forma definitiva
RUN git clone https://github.com /tmp/tpu-lab \
    && cp -r /tmp/tpu-lab/* /app/ \
    && rm -rf /tmp/tpu-lab

# 4. Cria o seu script entrypoint diretamente aqui para evitar erros de arquivo ausente
RUN printf '#!/bin/bash\n\
mkdir -p ~/.kaggle\n\
echo "{\\"username\\":\\"${KAGGLE_USERNAME}\\",\\"key\\":\\"${KAGGLE_KEY}\\"}" > ~/.kaggle/kaggle.json\n\
chmod 600 ~/.kaggle/kaggle.json\n\
echo "Iniciando controle remoto da TPU no Kaggle..."\n\
exec python launch.py serve\n' > /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
