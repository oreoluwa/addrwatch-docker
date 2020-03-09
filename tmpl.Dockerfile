FROM {{ .RuntimeImage }}

RUN apt-get update -y && apt-get install git automake libpcap-dev libevent-dev pkg-config build-essential libsqlite3-dev default-libmysqlclient-dev -y

RUN git clone https://github.com/fln/addrwatch.git /var/app

WORKDIR /var/app

RUN ./bootstrap.sh

RUN ./configure --enable-sqlite3 --enable-mysql

RUN make && make install

CMD ["addrwatch"]
