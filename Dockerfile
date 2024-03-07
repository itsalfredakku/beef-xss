FROM ruby:3.0

# Set up environment
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
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
    libcurl4-openssl-dev \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Clone BeEF
RUN git clone https://github.com/beefproject/beef.git /beef

# Set working directory to BeEF
WORKDIR /beef

# Install BeEF
RUN ./install

# Expose BeEF port
EXPOSE 3000

# Set entrypoint
ENTRYPOINT ["./entrypoint.sh"]
