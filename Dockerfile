FROM node:slim

ARG DATABASE_URL

ENV DATABASE_URL=${DATABASE_URL}

RUN apt-get update \
    apt-get install -y apt-transport-https

# Install latest chrome dev package and fonts to support major charsets (Chinese, Japanese, Arabic, Hebrew, Thai and a few others)
# Note: this installs the necessary libs to make the bundled version of Chromium that Puppeteer
# installs, work.
RUN apt-get install -y wget gnupg git \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/bendobos/webscraper-bot.git --depth 1
WORKDIR webscraper-bot

RUN yarn
RUN yarn run build

CMD ["/bin/bash", "-c", "npx prisma migrate dev;npx prisma migrate deploy;npm run start"]