FROM node:20-slim

RUN npm install -g antigravity-claude-proxy@latest

WORKDIR /app

CMD ["antigravity-claude-proxy", "start"]
