# electrumx-docker
Dockerfile for [electrumx](https://github.com/berycoin-project/electrumx) on Ubuntu with leveldb and daemontools.

## Usage
### Step 1. Configuration
```
git clone https://github.com/berycoin-project/electrumx-docker.git
cd electrumx-docker
```

Then,Edit `env/COIN` to your coin.

Edit `env/DAEMON_URL` accordingly.Need to match your daemon.

For AltCoins,edit your coin class in `env/coins.py`.`env/coins.py` will be append to [electrumx/lib/coins.py](https://github.com/berycoin-project/electrumx/blob/master/lib/coins.py)

Leave others defaults

### Step 2.Run
Run from docker hub:
```shell
    docker run -v env:/env  -idt berycoin-project/electrumx
```

Or,build your special env docker image :
```shell
      docker build -t electrumx .
      docker run -v /home/electrumx/electrumx electrumx
```

Find Container ID
```
sudo docker ps
```

access docker container
```
sudo docker exec -it <container id> bash
```

access docker container
```
sudo docker stop <container id>
```

## THANKS

### Warmly welcome all kinds of suggestions

Thanks for suggestions from:

[kyuupichan](https://github.com/kyuupichan/electrumx)

[qinshulei](https://github.com/qinshulei)

