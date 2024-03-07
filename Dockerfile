FROM parrotsec/core

# Set up environment
ENV LC_ALL C.UTF-8
ENV STAGING_KEY=RANDOM
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM xterm

# Update packages and install necessary tools
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

# Copy ./entrypoint.sh to /beef
COPY ./entrypoint.sh /beef

# Set working directory to BeEF
WORKDIR /beef

# Debug: Display the contents of the installation script
RUN cat ./install

# Debug: Try running the installation script manually
RUN chmod +x ./install && ./install

# Install BeEF
RUN ./install

# Set entrypoint app directory
ENTRYPOINT ["./entrypoint.sh"]

# Expose BeEF port
EXPOSE 3000

CMD ["/bin/sh"]
