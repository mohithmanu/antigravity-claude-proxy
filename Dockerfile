FROM node:20-alpine

WORKDIR /app

# copy dependency files first
COPY package.json package-lock.json* ./

# install dependencies
RUN npm ci

# copy rest of project
COPY . .

ENV PORT=8080

CMD ["npm", "start"]
