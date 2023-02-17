FROM debian:buster-slim

RUN apt-get update && \
    apt-get install -y curl fuse nginx && \
    rm -v /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/

RUN curl -L -O https://github.com/GoogleCloudPlatform/gcsfuse/releases/download/v0.42.2/gcsfuse_0.42.2_amd64.deb \
    && dpkg --install gcsfuse_0.42.2_amd64.deb \
    && rm gcsfuse_0.42.2_amd64.deb

COPY entrypoint.sh .

CMD /bin/bash ./entrypoint.sh && service nginx start