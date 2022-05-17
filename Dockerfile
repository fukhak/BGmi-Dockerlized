FROM alpine:3.13

ENV BGMI_PATH="/app"
ENV BGMI_SAVE_PATH="/data"
ENV BGMI_DATA_SOURCE="bangumi_moe" 
ENV BGMI_ADMIN_TOKEN="1234"
ENV BGMI_ENABLE_GLOBAL_FILTER="true" 

ADD ./BGmi /src
VOLUME ${BGMI_PATH}
VOLUME ${BGMI_SAVE_PATH}
RUN { \
	apk add --update bash python3 curl gcc musl-dev python3-dev libffi-dev openssl-dev cargo; \
	curl https://bootstrap.pypa.io/get-pip.py | python3; \
	pip install 'requests[security]'; \
	pip install /src && rm -rf /src; \
}

ADD ./script /script
RUN chmod +x /script/*.sh
EXPOSE 80
ENTRYPOINT [ "/script/run.sh" ]
CMD [ "start" ]