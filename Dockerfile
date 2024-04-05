# Stage 1: Build
FROM node:16-alpine AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY . .
RUN npm run build

# Stage 2: Run
FROM node:16-alpine
WORKDIR /usr/src/app
COPY --from=builder /usr/src/app/node_modules ./node_modules
COPY --from=builder /usr/src/app/dist ./dist
COPY --from=builder /usr/src/app/package*.json ./

CMD ["node", "dist/main"]