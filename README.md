# docker-ushahidi-client

Docker container for [Ushahidi client][3]

"Make smart decisions with a data management system that rapidly collects data from the crowd and visualizes what happened, when and where."

Note: For version 3 you need to deploy first the ushhidi-platform (quantumobject/docker-ushahidi-platform container ) and ushhidi-client (quantumobject/docker-ushahidi-client container). 

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 18.04 use the commands:

    sudo apt-get update
    sudo wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

Before you be able to use this container you need first to deploy quantumoject/docker-ushahidi-platform and use the http://ip:port reference of it to _-e PLATFORM="http://ip:port"_ for entry for this container. 

To run container use the commands below:

    docker run -d -p 8080:80 --add-host platform-api:external_ip --add-host api.ushahidi.test:external_ip --name ushahidi-platform quantumobject/docker-ushahidi-platform

It will take some time to install, generate and configured files for container , need to check logs output to find the APP_KEY for the next Container, for the majority of cases external_ip and ip_platform will be the same :

    docker logs ushahidi-platform

    docker run -d -p 80:80 -e PLATFORM="http://ip_platform:8080" -e APP_KEY='.....' --name ushahidi-client quantumobject/docker-ushahidi-client
  
You need to wait few min for the application to finish installing the client before try to access it.

note: needed "--add-host platform-api:external_ip --add-host api.ushahidi.test:external_ip" to modified /etc/hosts inside of container.

## Accessing the Ushahidi Client applications:

After that check with your browser at addresses plus the port assigined by docker for this container :

  - **http://host_ip/**

The original login/password will be admin/admin please replace password right away.  

To access the container from the server that the container is running :

     docker exec -it container_id /bin/bash
    
note: deploy this container behind proxy with SSL :

https://github.com/jwilder/nginx-proxy

https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion

## More Info

About Ushahidi Platform: [www.ushahidi.com][1]

To help improve this container [quantumobject/docker-ushahidi-client][5]

For additional info about us and our projects check our site [www.quantumobject.org][6]

[1]:http://www.ushahidi.com/
[2]:https://www.docker.com
[3]:http://www.ushahidi.com/product/ushahidi/
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-ushahidi-client
[6]:https://www.quantumobject.org/
