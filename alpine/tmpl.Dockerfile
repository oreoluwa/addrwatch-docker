FROM {{ .RuntimeImage }}

RUN apk --no-cache add libpcap-dev libevent-dev sqlite-dev mariadb-dev

RUN apk --no-cache add --virtual build-dependencies alpine-sdk autoconf automake argp-standalone

RUN git clone https://github.com/fln/addrwatch.git /var/app

WORKDIR /var/app

RUN ./bootstrap.sh

RUN ./configure --enable-sqlite3 --enable-mysql

RUN make && make install

RUN apk del build-dependencies

CMD ["addrwatch"]