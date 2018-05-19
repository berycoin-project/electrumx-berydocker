FROM ubuntu:16.04
MAINTAINER bago213 "bago@live.be"

ARG COMMONNAME

RUN apt-get update \
    && apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils \
    && apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-program-options-dev libboost-test-dev libboost-thread-dev \
    && apt-get install -y libboost-all-dev \
    && apt-get install -y software-properties-common \
    && add-apt-repository -y ppa:bitcoin/bitcoin \
    && apt-get update \
    && apt-get install -y libdb4.8-dev libdb4.8++-dev \
    && apt-get install -y libminiupnpc-dev \
    && apt-get install -y libzmq3-dev \
    && apt-get install -y libqrencode-dev \    
    && apt-get update \
    && apt-get install -y letsencrypt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /ssl/privkey.pem \
        -out /ssl/cert.pem \
        -subj /CN=$COMMONNAME \    
    && apt-get install -y software-properties-common --no-install-recommends \
    && add-apt-repository -y ppa:jonathonf/python-3.6 \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       python3.6 python3.6-dev libleveldb-dev wget git \
       libssl-dev daemontools nano build-essential \
    && rm /usr/bin/python3 \
    && ln -s /usr/bin/python3.6 /usr/bin/python3 \
    && wget https://bootstrap.pypa.io/get-pip.py -O- | python3.6 \
    && pip install scrypt \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  \
    && mkdir /log /db /env \
    && groupadd -r electrumx \
    && useradd -s /bin/bash -m -g electrumx electrumx \
    && chown -R electrumx:electrumx /ssl \
    && cd /home/electrumx \
    && git clone https://github.com/berycoin-project/berycoin.git \
    && chown -R electrumx:electrumx berycoin \
    && mkdir /home/electrumx/.berycoin \
    && cd /home/electrumx \
    && chown -R electrumx:electrumx .berycoin \
    && git clone https://github.com/berycoin-project/electrumx.git \
    && chown -R electrumx:electrumx electrumx && cd electrumx \
    && chown -R electrumx:electrumx /log /db /env \
    && python3.6 setup.py install
    
USER electrumx

VOLUME /db /log /env

COPY env/* /env/
COPY berycoin/* /home/electrumx/.berycoin/

RUN cd ~ \
    && cd /home/electrumx/berycoin \
    && git checkout 0.15 \
    && /home/electrumx/berycoin/autogen.sh \
    && /home/electrumx/berycoin/configure \
    && make -j4 \
    && cd ~ \
    && mkdir -p ~/service ~/scripts/electrumx \
    && cp -R ~/electrumx/contrib/daemontools/* ~/scripts/electrumx \
    && chmod +x ~/scripts/electrumx/run \
    && chmod +x ~/scripts/electrumx/log/run \
    && sed -i '$d' ~/scripts/electrumx/log/run \
    && sed -i '$a\exec multilog t s500000 n10 /log' ~/scripts/electrumx/log/run  \
    && cp /env/* /home/electrumx/scripts/electrumx/env/ \
    && cat ~/scripts/electrumx/env/coins.py >> ~/electrumx/lib/coins.py \
    && ln -s ~/scripts/electrumx  ~/service/electrumx
    
CMD ["bash","-c","/home/electrumx/berycoin/src/berycoind &"]

CMD ["bash","-c","cp /env/* /home/electrumx/scripts/electrumx/env/ && svscan ~/service"]
