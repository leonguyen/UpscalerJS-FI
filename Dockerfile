FROM node:18-alpine

ENV NODE_ENV=production
ENV CI=true

# Make sure npm is there
RUN npm --version

WORKDIR /app

# Copy package files first
COPY package*.json ./

# Use npm install if you don’t strictly need ci
RUN npm ci --omit=dev

# Copy source
COPY server.js ./

EXPOSE 3000

CMD ["npm", "start"]
