FROM node:alpine3.10

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app
RUN mkdir -p /home/node/app/error && chown -R node:node /home/node/app
RUN mkdir -p /home/node/app/content && chown -R node:node /home/node/app
RUN mkdir -p /home/node/app/acl && chown -R node:node /home/node/app

WORKDIR /home/node/app

COPY package*.json ./
COPY app.js ./
COPY config.json ./
COPY /error/401.html ./error/401.html
COPY /error/404.html ./error/404.html
COPY /acl/security.json ./acl/security.json


USER node

RUN npm install

COPY --chown=node:node . .

EXPOSE 8888

CMD [ "node", "app.js" ]