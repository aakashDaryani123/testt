FROM node:22-slim

WORKDIR /app

# Install necessary system dependencies
RUN apt-get update && apt-get install -y wget gnupg ca-certificates fonts-liberation libatk-bridge2.0-0 libnspr4 libnss3 libxss1 libasound2 libxcomposite1 libxdamage1 libxrandr2 xdg-utils

# Install Puppeteer and Chrome
COPY package*.json ./
RUN npm ci

COPY . .

# Install Chrome using Puppeteer's browser manager
RUN npx puppeteer browsers install chrome

CMD ["node", "index.js"]
