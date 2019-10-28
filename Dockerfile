FROM node:10.15.0

RUN apt-get update && \
    apt-get install -y \
    libnss3 \
    libpng-dev \
    build-essential

# install Chromebrowser
RUN \
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update
RUN apt-get install -y google-chrome-stable
RUN rm -rf /var/lib/apt/lists/*

# Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

# Puppeteer v1.9.0 works with Chromium 71.
RUN yarn add puppeteer@1.9.0

ENTRYPOINT ["dumb-init", "--"]
CMD ["google-chrome"]
