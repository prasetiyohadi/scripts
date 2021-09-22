FROM python:3.8-slim as builder
WORKDIR /tmp
COPY . /tmp
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y make \
    && make build

FROM nginx:1.21-alpine
COPY --from=builder /tmp/nginx/default.conf /etc/nginx/conf.d/
COPY --from=builder /tmp/site/ /usr/share/nginx/html/
