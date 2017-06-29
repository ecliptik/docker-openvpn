# docker-openvpn
Docker stack with [OpenVPN](https://openvpn.net), [Transmission](https://transmissionbt.com), and a reverse [nginx](http://nginx.org) proxy.

This is useful if you want to run containers over a VPN but don't want to run the openvpn directly on a container host. It uses [Docker Container Networking](https://docs.docker.com/compose/networking/ )and requires [docker-engine](https://github.com/moby/moby) 1.10+ and [docker-compose](https://github.com/docker/compose) 1.6.0+, although more current versions are highly recommended.

## Files

- Dockerfile.openvpn
  - Takes a .ovpn configuration and connects an openvpn client
- Dockerfile.transmission
  - Runs the `transmission-daemon` bittorrent application
  - Listens on port 20000 for incoming UDP connections
  - Listens on port 9091 for RPC (web) connections
- docker-compose.yml
  - Brings up OpenVPN, Transmission, and Nginx containers
  - `openvpn` service will connect to VPN, granting NET_ADMIN capability and using the `/dev/net/tun` device for VPN
  - `transmission` service brings up Transmission listening on port 9091 and volume mounts a local directory for stateful configuration
    - Uses the `openvpn` service networking to route all traffic over the VPN
  - `nginx` service proxies incoming requests to port 9091 on the container hosts interface and routs traffic to `transmission` service
    - required since port 9091 on the `transmission` service does not listen on the container hosts network interface since it's using the `openvpn` service network

## Configuration

- OpenVPN
  - Download/generate a `.ovpn` configuration and update the `Dockerfile.ovpn` configuration to copy it into the container at build time
- Transmission
  - All transmission settings are stateful and are defined in the volume mount, which defaults to `/opt/transmission`. Put the `settings.json` file thereand it will be used everytime the service starts up. This allows for resuming and stateful operation.
- Nginx
  - Simple reverse proxy, but could include SSL and other configuration if needed.

## Running

The `docker-compose.yml` file will bring up a container stack, building the required containers the first time.

Bring the stack up

```
docker-compose up
```

Re-building

```
docker-compose build
docker-compose up
```

Stdout will show the `openvpn` service making the connection, and after 10 seconds the `transmission` service will start, using the `openvpn` service networking and routing all traffic over OpenVPN.

Once the stack is running, connect to the nginx reverse proxy to use Transmission at http://localhost:9091.

