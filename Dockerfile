FROM node:20-alpine AS builder
WORKDIR /app

COPY package*.json ./
RUN if [ -f package-lock.json ]; then npm ci --no-audit --no-fund; else npm install --no-audit --no-fund; fi

COPY . ./
RUN npm run build

FROM node:20-alpine AS runner
WORKDIR /app

LABEL org.opencontainers.image.title="Antigravity-claud-proxy"

ENV NODE_ENV=production
ENV PORT=8080
RUN mkdir -p /root/.config/antigravity-proxy /root/.claude

CMD ["npm", "start", "--", "--log"]
