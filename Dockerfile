FROM nginx:latest
EXPOSE 7860
WORKDIR /app
USER root

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.json ./
COPY entrypoint.sh ./
COPY LensPause-main.zip ./
RUN apt-get update && apt-get install -y wget unzip iproute2 systemctl && \
    chmod -v 755 entrypoint.sh

ENTRYPOINT [ "./entrypoint.sh" ]
