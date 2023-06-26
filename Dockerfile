FROM node:slim

ARG CLIENT_ID
ARG CLIENT_TOKEN
ARG DATABASE_URL
ARG PORT

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/bendobos/webscraper-bot.git --depth 1
WORKDIR webscraper-bot

RUN yarn
RUN yarn run build

ENTRYPOINT ["npm", "start"]