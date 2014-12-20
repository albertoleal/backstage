FROM       ubuntu:latest
MAINTAINER Wilson Júnior <wilsonpjunior@gmail.com>

RUN apt-get update
RUN apt-get install -y golang make git
RUN apt-get install -y mercurial meld bzr
RUN apt-get install -y mongodb redis-server

ENV GOPATH /opt/go
RUN mkdir -p $GOPATH/src/github.com/backstage

# Create the MongoDB data directory
RUN mkdir -p /data/db

WORKDIR $GOPATH/src/github.com/backstage
RUN git clone https://github.com/backstage/backstage
WORKDIR $GOPATH/src/github.com/backstage/backstage
RUN make build

ADD /scripts/docker-run.sh /usr/bin/run.sh


EXPOSE 8000
ENTRYPOINT ["/usr/bin/run.sh"]
