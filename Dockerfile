FROM ruby:3.0-slim

WORKDIR /home/

ENV LC_ALL C.UTF-8
ENV STAGING_KEY RANDOM
ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

# Install required dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        net-tools \
        curl \
        git \
        build-essential \
        openssl \
        libreadline6-dev \
        zlib1g \
        zlib1g-dev \
        libssl-dev \
        libyaml-dev \
        libsqlite3-0 \
        libsqlite3-dev \
        sqlite3 \
        libxml2-dev \
        libxslt1-dev \
        autoconf \
        libc6-dev \
        libncurses5-dev \
        automake \
        libtool \
        bison \
        nodejs \
    && rm -rf /var/lib/apt/lists/*

# Clone the beef repository
RUN git clone --depth=1 --recursive https://github.com/beefproject/beef/ /home/beef

# Copy the install script into the beef directory
COPY install /home/beef/install


# Run the install script
RUN cd /home/beef \
    && ./install

# Remove unnecessary files and packages
RUN rm -rf /home/beef/.git \
    && apt-get remove -y git build-essential automake \
    && apt-get autoremove -y

WORKDIR /home/beef/

#NOTE - have to chmod 755 entrypoint script on source filesystem or it will not be executable inside container!
COPY entrypoint.sh /home/beef/entrypoint.sh
ENTRYPOINT ["/home/beef/entrypoint.sh"]

EXPOSE 3000

CMD ["/bin/sh"]
