FROM google/debian:wheezy

RUN apt-get update && apt-get install -y fortunes


# Install java8
#run add-apt-repository -y ppa:webupd8team/java
#run apt-get update
#run echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
#run apt-get install -y oracle-java8-installer

# Install java8
# ONBUILD RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
# ONBUILD RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
# ONBUILD RUN echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections
# ONBUILD RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
# ONBUILD RUN apt-get update
# ONBUILD RUN apt-get install -y oracle-java8-installer

# add webupd8 repository
RUN \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list  && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886  && \
    apt-get update


# install Java
RUN \
    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections  && \
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections  && \
    apt-get install -y --force-yes oracle-java8-installer oracle-java8-set-default  && \
    apt-get clean

ADD target/universal/play-managed-vm-1.0-SNAPSHOT.tgz /app

#RUN tar -xvzf /app/play-managed-vm-1.0-SNAPSHOT.tgz

#RUN chmod +x /app/play-managed-vm-1.0-SNAPSHOT/bin/play-managed-vm

#WORKDIR /app/play-managed-vm-1.0-SNAPSHOT/bin/

EXPOSE 8080

CMD ["/app/play-managed-vm-1.0-SNAPSHOT/bin/play-managed-vm", "-Dhttp.port=8080"]
# ENTRYPOINT ["/bin/sh", "/app/play-managed-vm-1.0-SNAPSHOT/bin/play-managed-vm"]

