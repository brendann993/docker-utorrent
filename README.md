Based on xenial from [LinuxServer.io](http://LinuxServer.io)

µTorrent is the #1 BitTorrent download client on desktops worldwide. [µTorrent](http://www.utorrent.com/)

## Usage

```
docker create --name=utorrent \
-v <path to data>:/config \
-v <path to media>:/media \
-e PGID=<gid> -e PUID=<uid> \
-e TZ=<timezone> \
-p 8080:8080 -p 6881:6881 \
brendann993/utorrent
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`


* `-p 8080` - the port(s)
* `-p 6881` - the port(s)
* `-v /config` - where utorrent should store it's config files
* `-v /media` - path to your downloads folder
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation
* `-e TZ` for timezone information, eg Europe/London

It is based on xenial linux with s6 overlay, for shell access whilst the container is running do `docker exec -it utorrent /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Webui can be found at `<your-ip>:8080/gui` , configuration files for µTorrent are stored in /config, and a sample configuration file is stored at /config/utserver.conf

## Info

* Shell access whilst the container is running: `docker exec -it utorrent /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f utorrent`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' utorrent`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' brendann993/utorrent`


## Versions

+ **06.08.17:** Intial Release.
