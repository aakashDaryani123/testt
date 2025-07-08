FROM node:22-slim

WORKDIR /app

# Install required packages for headless Chrome
RUN apt-get update && apt-get install -y \
    wget \
    ca-certificates \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libx11-xcb1 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    xdg-utils \
    libgbm1 \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy and install Node dependencies
COPY package*.json ./
RUN npm ci

# Copy app files
COPY . .

# Install headless Chrome via Puppeteer
RUN npx puppeteer browsers install chrome

CMD ["node", "index.js"]
