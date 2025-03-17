FROM docker:28.0.1

RUN apk update \
  && apk upgrade \
  && apk add --no-cache --update python3 py3-pip coreutils bash \
  && rm -rf /var/cache/apk/* \
  && python3 -m venv ~/py_envs \
  && source ~/py_envs/bin/activate \
  && pip3 install --upgrade pip \
  && pip3 install pyyaml==5.3.1 \
  && pip3 install -U awscli \
  && apk --purge -v del py3-pip

ADD entrypoint.sh /entrypoint.sh

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
