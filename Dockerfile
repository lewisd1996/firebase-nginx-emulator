FROM node:20-alpine

ARG FIREBASE_VERSION=13.3.0

RUN apk --no-cache add openjdk11-jre bash curl openssl nginx && \
    npm i -g firebase-tools@$FIREBASE_VERSION

COPY nginx.conf /etc/nginx/
COPY serve.sh /usr/bin/

# Remove Windows carriage return characters
RUN sed -i 's/\r$//' /usr/bin/serve.sh && chmod +x /usr/bin/serve.sh

WORKDIR /srv/firebase

ENTRYPOINT ["/usr/bin/serve.sh"]
