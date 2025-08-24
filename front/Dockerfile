FROM node:20-slim

WORKDIR /app

# Копіюємо package.json і package-lock.json (якщо є)
COPY package*.json ./
COPY tsconfig*.json ./
COPY vite.config.* ./

RUN npm config set package-lock true

# Встановлюємо залежності
RUN npm install

# Копіюємо весь код у контейнер (src, public, etc.)
COPY . .

EXPOSE 8080

# Запускаємо Vite dev server
CMD ["npm", "run", "dev"]

