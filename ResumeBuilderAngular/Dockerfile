FROM node:18-alpine

RUN mkdir /opt/frontend

COPY . /opt/frontend

WORKDIR /opt/frontend

RUN npm install --force

RUN npm run build --omit=dev

RUN npm install -g @angular/cli


CMD [ "npm", "start" ]
