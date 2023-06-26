FROM node:alpine

ARG CLIENT_ID
ARG CLIENT_TOKEN
ARG DATABASE_URL
ARG PORT

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/bendobos/webscraper-bot.git --depth 1
RUN cd webscraper-bot
RUN npm install
RUN tsc

ENTRYPOINT ["npm", "start"]