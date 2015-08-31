#name of container: docker-ushahidi-platform-client
#versison of container: 0.1.0
FROM quantumobject/docker-baseimage
MAINTAINER Angel Rodriguez  "angel@quantumobject.com"

#add repository and update the container
#Installation of nesesary package/software for this containers...
RUN echo "deb http://archive.ubuntu.com/ubuntu utopic-backports main restricted " >> /etc/apt/sources.list
RUN apt-get update && curl -sL https://deb.nodesource.com/setup | sudo bash - \
                                            && apt-get install -y -q build-essential \
                                            libnotify-bin \
                                            nodejs \
                                            apache2 \  
                                            git-core \
                    && apt-get clean \
                    && rm -rf /tmp/* /var/tmp/*  \
                    && rm -rf /var/lib/apt/lists/*
                    
#General variable definition        
ENV PLATFORM localhost

##startup scripts  
#Pre-config scrip that maybe need to be run one time only when the container run the first time .. using a flag to don't 
#run it again ... use for conf for service ... when run the first time ...
RUN mkdir -p /etc/my_init.d
COPY startup.sh /etc/my_init.d/startup.sh
RUN chmod +x /etc/my_init.d/startup.sh

##Adding Deamons to containers
# to add apache2 deamon to runit
RUN mkdir /etc/service/apache2
COPY apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/apache2/run


#add files and script that need to be use for this container
#include conf file relate to service/daemon 
#additionsl tools to be use internally
COPY apache2.conf /etc/apache2/apache2.conf
RUN sed  -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/platform-client\/server\/www/' /etc/apache2/sites-available/000-default.conf

#pre-config scritp for different service that need to be run when container image is create 
#maybe include additional software that need to be installed ... with some service running ... like example mysqld
COPY pre-conf.sh /sbin/pre-conf
RUN chmod +x /sbin/pre-conf \
    && /bin/bash -c /sbin/pre-conf \
    && rm /sbin/pre-conf

##scritp that can be running from the outside using docker-bash tool ...
## for example to create backup for database with convitation of VOLUME   dockers-bash container_ID backup_mysql
COPY backup.sh /sbin/backup
RUN chmod +x /sbin/backup
VOLUME /var/backups

# to allow access from outside of the container  to the container service
# at that ports need to allow access from firewall if need to access it outside of the server. 
EXPOSE 80

#creatian of volume 
VOLUME /var/www/

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]
