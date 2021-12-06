# Stage: Dependencies
FROM node:alpine AS deps
ARG NPM_TOKEN

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat
WORKDIR /app
COPY package.json yarn.lock ./

RUN printf "@elanco:registry=https://npm.pkg.github.com/ \n//npm.pkg.github.com/:_authToken=${NPM_TOKEN}" > .npmrc && \
    yarn install --frozen-lockfile && \
    rm -f .npmrc

# Stage: Build
FROM node:alpine AS builder

WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules

FROM node:alpine AS builder
ARG NPM_TOKEN

WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN printf "@elanco:registry=https://npm.pkg.github.com/ \n//npm.pkg.github.com/:_authToken=${NPM_TOKEN}" > .npmrc && \
    yarn build && yarn install --production --ignore-scripts --prefer-offline && \
    rm -f .npmrc

# Stage: Production
FROM node:alpine AS runner
WORKDIR /app

ENV NODE_ENV production

RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# You only need to copy next.config.js if you are NOT using the default configuration
# COPY --from=builder /app/next.config.js ./
COPY --from=builder /app/public ./public
COPY --from=builder --chown=nextjs:nodejs /app/.next ./.next
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./package.json

USER nextjs

EXPOSE 8080

ENV PORT 8080
ENV NEXT_TELEMETRY_DISABLED 1

CMD ["node_modules/.bin/next", "start"]