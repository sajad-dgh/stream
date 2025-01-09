FROM node as builder
WORKDIR /app
COPY ./package.json ./package-lock.json ./
RUN npm install --target=16 --target_platform=linux --target_arch=x64 --target_lib=musl
COPY . ./
RUN npm run build

FROM node
WORKDIR /app
COPY --from=builder /app ./
EXPOSE 3000
CMD ["npm","run","start:prod"]