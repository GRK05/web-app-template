FROM node:16 AS builder

WORKDIR /app

# separate dependency installation from build
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .
RUN yarn build


FROM node:16-alpine AS runner

ARG APP_PORT=8080

ENV PORT ${APP_PORT}
EXPOSE ${APP_PORT}

WORKDIR /app

COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

CMD ["node", "dist/index.js"]
