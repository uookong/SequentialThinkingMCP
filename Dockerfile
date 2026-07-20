# Use official Node.js 20 image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install all dependencies (including devDependencies for build)
RUN npm ci

# Copy source files
COPY . .

# Build TypeScript
RUN npm run build

# Use supergateway to convert stdio to SSE
CMD ["npx", "supergateway", "node", "dist/index.js", "--healthPath", "/health"]
