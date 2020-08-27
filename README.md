# Image docker to to execute a tcp tunnel through rdp  

```
    [+] AUTOR:        Gerardo Junior
    [+] SITE:         https://gerardo-junior.com
    [+] EMAIL:        me@gerardo-junior.com
    [+] GITHUB:       https://github.com/gerardo-junior/rdp2tcp-docker.git
    [+] TELEGRAM:     @MrGerardoJunior
```

## Come on, do your tests

```bash
docker pull gerardojunior/rdp2tcp:stable
```
## How to build

to build the image you need install the [docker engine](https://www.docker.com/) only

> You can try building with different versions of software with docker args, for example: RDP2TCP_VERSION=2020.08.26-0

```bash
docker build https://github.com/gerardo-junior/rdp2tcp-docker.git --tag gerardojunior/rdp2tcp
```

## How to use 


```bash
docker run --rm \
           -it \
           -e USERNAME="[USERNAME]" \
           -e PASSWORD="[PASSWORD]" \
           -e HOST="[HOST]"
           -e PORTS="22:22" \
         # -p 1000:22 \ # optional option for local port binding
           gerardojunior/rdp2tcp
```

wait for the message "**virtual channel connected**" this may take a few seconds (the time for the host to connect and run rdp2tcp server)

### Just connect to your host
```bash
ssh [ip container or localhost if you set local port binding]
```

#### for more than one port you can use ";" in the $ PORT variable

EX .: -e PORTS = "22:22;3000:80"

> [more information how it works](https://github.com/gerardo-junior/rdp2tcp)


## How to enter in shell

docker run -it --rm gerardojunior/rdp2tcp:stable bash


### License  
This project is licensed under the MIT License - see the [LICENSE](https://github.com/gerardo-junior/rdp2tcp-docker/blob/master/LICENSE) file for details
