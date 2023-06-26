FROM node:alpine

ARG CLIENT_ID
ARG CLIENT_TOKEN
ARG DATABASE_URL
ARG PORT

RUN apk update && apk add --no-cache --upgrade git bash

RUN git clone https://github.com/bendobos/webscraper-bot.git --depth 1
WORKDIR webscraper-bot
RUN npm install
RUN tsc

ENTRYPOINT ["npm", "start"]