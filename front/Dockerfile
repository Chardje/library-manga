FROM node:20-slim

WORKDIR /app

# Встановлюємо залежності та інструменти для dev-режиму
COPY package*.json ./
RUN npm install && npm install -g http-server concurrently typescript nodemon

COPY tsconfig.json ./

# Не копіюємо src, public, image -- вони підключаються як volume

# Для dev-режиму: автоматична перекомпіляція та автосервер
CMD ["sh", "-c", "mkdir -p dest && cp src/style.css dest/style.css && concurrently --kill-others \"nodemon --legacy-watch --watch src --ext ts --exec \\\"tsc\\\"\" \"http-server dest -p 80 -c-1\""]

# Для продакшн-збірки (залиште закоментованим, якщо потрібно)
# RUN npx tsc
# COPY dest ./dest
#CMD ["http-server", "dest", "-p", "80"]
