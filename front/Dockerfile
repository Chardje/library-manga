FROM node:20-slim

WORKDIR /app

# Встановлюємо залежності та інструменти для dev-режиму
COPY package*.json ./
RUN npm install && npm install -g http-server concurrently

COPY tsconfig.json ./

# Не копіюємо src, public, image -- вони підключаються як volume

# Для dev-режиму: автоматична перекомпіляція та автосервер
CMD ["concurrently", "--kill-others", "tsc --watch --preserveWatchOutput", "http-server dest -p 80"]

# Для продакшн-збірки (залиште закоментованим, якщо потрібно)
# RUN npx tsc
# COPY dest ./dest
CMD ["http-server", "dest", "-p", "80"]
