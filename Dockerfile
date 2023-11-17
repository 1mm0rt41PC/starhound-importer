FROM node:latest
RUN mkdir /code && \
    mkdir /data
COPY . /code/starhound-importer
WORKDIR /code/starhound-importer
RUN ([ -n "$https_proxy" ] && (npm config set strict-ssl false;npm config set proxy $https_proxy)) ; npm install --save-dev  --loglevel verbose ; npm run build  --loglevel verbose
CMD sh -c "node /code/starhound-importer/bin/main.js preprocess; cd /data; find /data/ -name '*.zip' -exec unzip -o {} \;; cd /code/starhound-importer; find /data/ -name '*.json' -exec node /code/starhound-importer/bin/main.js {} \;; node /code/starhound-importer/bin/main.js postprocess;"

# Debug process
# docker run -it -w /code/starhound-importer -v ./:/code/starhound-importer -v $NEO4J_IMPORT:/data --network=host --env-file .env node:latest bash
#	./node_modules/.bin/babel --retain-lines --compact false --source-maps true src/ --ignore "src/BloodHound/*" -d bin/
#	node /code/starhound-importer/bin/main.js preprocess
#	node /code/starhound-importer/bin/main.js  xxxx
#	node /code/starhound-importer/bin/main.js postprocess