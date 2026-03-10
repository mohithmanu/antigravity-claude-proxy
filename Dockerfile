# Use Node.js 18 or later as specified in prerequisites
FROM node:20-alpine

# Install basic dependencies for the WebUI and CLI
WORKDIR /app

# Copy package files first for better caching
COPY package*.json ./

# Install dependencies (including production only)
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Create the config directory where accounts and settings are stored
# The app defaults to ~/.config/antigravity-proxy or ~/.claude
RUN mkdir -p /root/.config/antigravity-proxy /root/.claude

# Environment variables
ENV NODE_ENV=production
ENV PORT=8080

# Start the proxy in the foreground (so the container doesn't exit)
# Using 'npm start' or direct node call to bin/cli.js
CMD ["npm", "start", "--", "--log"]
