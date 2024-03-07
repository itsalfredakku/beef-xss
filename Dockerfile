FROM ruby:3.0-slim
#FROM ruby:2.7.5-alpine

WORKDIR /home/

ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

RUN apt-get update
RUN apt-get install -y net-tools curl git build-essential openssl libreadline6-dev zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev autoconf libc6-dev libncurses5-dev automake libtool bison nodejs
RUN cd /home/
RUN git clone --depth=1 --recursive https://github.com/beefproject/beef/ /home/beef
RUN cd /home/beef
RUN ./install
RUN rm -rf /home/beef/.git
RUN apt-get remove -y git build-essential automake
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /home/beef/

#NOTE - have to chmod 755 entrypoint script on source filesystem or it will not be executable inside container!
COPY entrypoint.sh /home/beef/entrypoint.sh
ENTRYPOINT ["/home/beef/entrypoint.sh"]

EXPOSE 3000

CMD ["/bin/sh"]


