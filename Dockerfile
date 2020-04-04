FROM ubuntu:18.04
MAINTAINER li haixin <lihaixin@15099.net>
WORKDIR /root
RUN apt-get update  && \
        apt-get -y install wget libappindicator3-1 libwebkit2gtk-4.0-37 && \
        wget https://raw.githubusercontent.com/getlantern/lantern-binaries/master/lantern-installer-64-bit.deb && \
        dpkg -i lantern-installer-64-bit.deb && \
        rm -rf lantern-installer-64-bit.deb && \
        apt-get -f install && \
        apt-get clean && \
        rm -rf /var/cache/apt/* /var/lib/apt/lists/* && \
        mkdir /root/.lantern && \
        echo "localHTTPToken: wilonlantern" > /root/.lantern/settings.yaml

EXPOSE 3128/tcp 3129/tcp 8080/tcp

ENTRYPOINT ["/usr/bin/lantern", "--configdir=/root", "--headless=true", "--proxyall=true", "--startup=false", "--clear-proxy-settings=false", "--addr=0.0.0.0:3128", "--uiaddr=0.0.0.0:8080", "--socksaddr=0.0.0.0:3129"]
