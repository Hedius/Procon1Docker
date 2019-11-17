FROM mono:latest

# user for execution
ARG UID=10000
ARG GID=10000
RUN RUN groupadd -r -g $GID procon && \
    useradd -r -g procon -u $UID procon


RUN mkdir -p /procon && \
	apt-get update && \
	apt-get install unzip wget -y && \
	wget -O /tmp/procon.zip https://api.myrcon.net/procon/download?p=docker && \
	unzip -x /tmp/procon.zip -d /procon/ && \
    rm -f /tmp/procon.zip
	
WORKDIR /procon

VOLUME /procon/Configs ./Configs
VOLUME /procon/Plugins ./Plugins

USER procon:procon

ENTRYPOINT [ "mono",  "PRoCon.Console.exe" ]
