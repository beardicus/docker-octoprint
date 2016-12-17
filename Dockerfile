FROM python:2.7-alpine
MAINTAINER Brian Boucheron <brian@boucheron.org>

RUN apk add --no-cache git build-base linux-headers wget \
    && git clone https://github.com/foosel/OctoPrint.git \
    && cd /OctoPrint \
    && python setup.py install \
    && cd /tmp \
    && wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz \
    && tar xJf ffmpeg-release-64bit-static.tar.xz \
    && cp ffmpeg-*-64bit-static/ffmpeg /usr/local/bin \
    && rm -rf /tmp/ffmpeg* \
    && mkdir /data

VOLUME /data
EXPOSE 5000

COPY config-defaults.yaml /
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["octoprint", "serve", "--iknowwhatimdoing", "--basedir", "/data"]
