FROM node:latest
RUN mkdir /code && \
    mkdir /data
COPY . /code/starhound-importer
WORKDIR /code/starhound-importer
RUN ([ -n "$https_proxy" ] && (npm config set strict-ssl false;npm config set proxy $https_proxy)) ; npm install --save-dev  --loglevel verbose ; npm run build  --loglevel verbose
CMD sh -c "node /code/starhound-importer/bin/main.js preprocess; cd /data; find /data/ -name '*.zip' -exec unzip -o {} \;; cd /code/starhound-importer; find /data/ -name '*.json' -exec node /code/starhound-importer/bin/main.js {} \;; node /code/starhound-importer/bin/main.js postprocess;"
