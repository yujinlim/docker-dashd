FROM phusion/baseimage
MAINTAINER Holger Schinzel <holger@dash.org>

ARG USER_ID
ARG GROUP_ID

ENV HOME /dash

# add user with specified (or default) user/group ids
ENV USER_ID ${USER_ID:-1000}
ENV GROUP_ID ${GROUP_ID:-1000}
RUN groupadd -g ${GROUP_ID} dash
RUN useradd -u ${USER_ID} -g dash -s /bin/bash -m -d /dash dash

ADD https://github.com/dashpay/dash/releases/download/v0.12.2.1/dashcore-0.12.2.1-linux64.tar.gz /tmp/
RUN tar -xvf /tmp/dashcore-*.tar.gz -C /tmp/
RUN cp /tmp/dashcore*/bin/*  /usr/local/bin
RUN rm -rf /tmp/dashcore*

ADD ./bin /usr/local/bin
COPY docker-entrypoint.sh /usr/local/bin/

RUN chmod a+x /usr/local/bin/*

VOLUME ["/dash"]

EXPOSE 9998 9999 19998 19999

WORKDIR /dash

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["dash_oneshot"]
