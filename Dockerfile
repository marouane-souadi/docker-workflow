FROM node:alpine as builder

WORKDIR '/app'

COPY package.json .
RUN npm config set registry="http://registry.npmjs.org/"
RUN npm install

COPY . .

RUN npm run build

FROM nginx

# For elasticbeanstalk to use the web server
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html