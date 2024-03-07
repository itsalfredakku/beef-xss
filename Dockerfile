FROM ruby:3.2.1-slim-bullseye

# Set up environment
ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM xterm

# Update package manager and install necessary tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    openssl \
    libreadline-dev \
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
    libcurl4-openssl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Clone BeEF repository
RUN git clone https://github.com/beefproject/beef.git /beef

# Copy entrypoint script
COPY ./entrypoint.sh /beef/entrypoint.sh

# Set working directory
WORKDIR /beef

# Install BeEF
RUN ./install

# Expose BeEF port
EXPOSE 3000

# Entrypoint script
ENTRYPOINT ["./entrypoint.sh"]
