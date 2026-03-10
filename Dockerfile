FROM node:20-slim

WORKDIR /app

COPY package*.json ./

ENV NODE_OPTIONS=--max-old-space-size=2048

RUN --mount=type=cache,target=/root/.npm \
    npm install --no-audit --no-fund

COPY . .

CMD ["npm","start"]
