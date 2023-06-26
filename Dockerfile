FROM node:slim

ARG DATABASE_URL

ENV DATABASE_URL=${DATABASE_URL}

RUN apt-get update && apt-get install -y git

RUN git clone https://github.com/bendobos/webscraper-bot.git --depth 1
WORKDIR webscraper-bot

RUN yarn
RUN yarn run build

CMD ["/bin/bash", "-c", "npx prisma migrate dev;npx prisma migrate deploy;npm run start"]