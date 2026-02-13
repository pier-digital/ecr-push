FROM docker:27.5.1

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --update python3 py3-pip coreutils bash \
  && rm -rf /var/cache/apk/* \
  && pip3 install --upgrade pip --break-system-packages \
  && pip3 install pyyaml==5.3.1 --break-system-packages \
  && pip3 install -U awscli==1.44.38 --break-system-packages \
  && apk --purge -v del py3-pip

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
