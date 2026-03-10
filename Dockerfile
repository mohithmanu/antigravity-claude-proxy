# syntax=docker/dockerfile:1.7

FROM node:20-slim AS builder

WORKDIR /app

# Reduce memory usage
ENV NODE_OPTIONS=--max-old-space-size=2048

# Install dependencies first (better caching)
COPY package*.json ./

RUN --mount=type=cache,target=/root/.npm \
    npm install --omit=dev --no-audit --no-fund

# Copy source
COPY . .

# ---------- runtime image ----------
FROM node:20-slim

WORKDIR /app

ENV NODE_ENV=production

# Copy only built app
COPY --from=builder /app /app

CMD ["npm","start"]
