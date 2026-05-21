# Use a slim Node base with ONNX‑related deps in mind
FROM node:18-alpine

# Avoid TZ prompts etc.
ENV TZ=UTC
ENV NODE_ENV=production

# Install minimal deps for tfjs‑node (CPU)
RUN apk add --no-cache python3 py3-pip build-base ffmpeg

WORKDIR /app

# Install tfjs‑node + upscaler (lock deps first)
COPY package*.json ./
RUN npm ci --omit=dev

# Copy source
COPY server.js ./

# Models: this example relies on the default model shipped with upscaler
# If you want to cache a specific model, seed it in /tmp or /models
# and mount a volume; for Fly, keep it simple and download on first run.

EXPOSE 3000

CMD ["npm", "start"]
