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

# Додаємо node_modules/.bin до PATH для доступу до локального vite
ENV PATH="/app/node_modules/.bin:${PATH}"

EXPOSE 8080

# Запускаємо Vite dev server
CMD ["npm", "run", "dev"]

