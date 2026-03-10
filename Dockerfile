# Use the PLATFORM argument provided by Buildx
FROM --platform=$BUILDPLATFORM node:18-slim AS base

WORKDIR /app

# Explicitly set the shell to ensure path resolution
SHELL ["/bin/sh", "-c"]

COPY package*.json ./

# If you have native dependencies (like node-gyp), 
# some arm64 builds require build-essential
RUN apt-get update && apt-get install -y python3 make g++ && rm -rf /var/lib/apt/lists/*

RUN npm install --production

COPY . .

CMD ["node", "src/index.js"]
