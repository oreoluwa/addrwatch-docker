FROM {{ .RuntimeImage }}

RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    git \
    automake \
    libpcap-dev \
    libevent-dev \
    pkg-config \
    build-essential \
    libsqlite3-dev \
    ca-certificates \
    default-libmysqlclient-dev && \
    apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/fln/addrwatch.git /var/app

WORKDIR /var/app

RUN ./bootstrap.sh

RUN ./configure --enable-sqlite3 --enable-mysql

RUN make && make install

CMD ["addrwatch"]
