# electrumx-docker
Dockerfile for [electrumx](https://github.com/berycoin-project/electrumx) on Ubuntu with leveldb and daemontools.

## Usage
### Step 1. Configuration
```
git clone https://github.com/berycoin-project/electrumx-berydocker.git
cd electrumx-berydocker
```
MUST:

Edit `env/HOST` to your coin.

Edit `env/REPORT_HOST` to your coin.

Edit `env/DAEMON_URL` accordingly.Need to match your daemon.

Edit `berycoin/berycoin.conf` accordingly.Need to match your RPCuser & RPCpassword in `env/DAEMON_URL`.

Leave others defaults

your coin class in `env/coins.py`.`env/coins.py` will append to [electrumx/lib/coins.py](https://github.com/berycoin-project/electrumx/blob/master/lib/coins.py)



### Step 2.Run
Run from docker hub:
```shell
sudo docker run -v env:/env  -idt berycoin-project/electrumx
```

edit COMMONNAME to `env/HOST_NAME` and build your special env docker image :
```shell
sudo docker build --build-arg COMMONNAME=electrum.berycoin.com -t electrumx .
sudo docker run -d --tmpfs /tmp --tmpfs /run -v /sys/fs/cgroup:/sys/fs/cgroup:ro electrumx
```
#sudo docker run --privileged=true -v /home/electrumx/electrumx electrumx

Find Container ID
```
sudo docker ps
```

access docker container
```
sudo docker exec -it <container id> bash
```

stop docker container
```
sudo docker stop <container id>
```

## THANKS

### Warmly welcome all kinds of suggestions

Thanks for suggestions from:

[kyuupichan](https://github.com/kyuupichan/electrumx)

[qinshulei](https://github.com/qinshulei)

