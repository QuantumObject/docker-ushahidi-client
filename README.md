# docker-ushahidi-platform-client

Docker container for [Ushahidi Platform client][3]

"Make smart decisions with a data management system that rapidly collects data from the crowd and visualizes what happened, when and where."

note: quantumobject/docker-ushahidi container  refer to version 2.7.4 that include client and platform together (old version) , for veriosn 3 you need to deploy first the ushhidi-platform (quantumobject/docker-ushahidi-platform container ) and ushhidi-platform-client (quantumobject/docker-ushahidi-platform-client container). 

## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 14.04 use the commands:

    $ sudo apt-get update
    $ wget -qO- https://get.docker.com/ | sh

 To install docker in other operating systems check [docker online documentation][4]

## Usage

Before you be able to use this container you need first to deploy quantumoject/docker-ushahidi-platform and use the http://ip:port reference of it to _-e platform="http://ip:port"_ for entry for this container. 

To run container use the command below:

    $ docker run -d -p 80 -e platform="http://ip_platform:port" quantumobject/docker-ushahidi-platform-client

## Accessing the Ushahidi Platform Client applications:

After that check with your browser at addresses plus the port assigined by docker for this container :

  - **http://host_ip:port/**

To access the container from the server that the container is running :

    $ docker exec -it container_id /bin/bash

## More Info

About Ushahidi Platform: [www.ushahidi.com][1]

To help improve this container [quantumobject/docker-ushahidi-platform][5]

[1]:http://www.ushahidi.com/
[2]:https://www.docker.com
[3]:http://www.ushahidi.com/product/ushahidi/
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-ushahidi-platform-client
