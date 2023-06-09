FROM node:latest
RUN mkdir /code
RUN mkdir /data
WORKDIR /code
RUN git clone --recurse-submodules -j8 https://github.com/malacupa/starhound-importer
WORKDIR /code/starhound-importer
RUN npm install --save-dev
RUN npm run build
CMD sh -c "node bin/main.js preprocess; find /data/ -name '*.json' -exec node bin/main.js {} \; node bin/main.js postprocess;"
