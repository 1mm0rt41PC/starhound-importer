FROM node:latest
RUN mkdir /code && \
    mkdir /data
COPY . /code/starhound-importer
WORKDIR /code/starhound-importer
RUN npm install --save-dev && \
    npm run build
CMD sh -c "node /code/starhound-importer/bin/main.js preprocess; cd /data; find /data/ -name '*.zip' -exec unzip {} \;; cd /code/starhound-importer; find /data/ -name '*.json' -exec node /code/starhound-importer/bin/main.js {} \;; node /code/starhound-importer/bin/main.js postprocess;"
