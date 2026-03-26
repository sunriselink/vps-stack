# Beszel

## Initial setup

Run only `beszel` container

```sh
docker compose up -d beszel

# Getting internal container ip (on server)
docker inspect beszel | jq -r ".[].NetworkSettings.Networks.beszel.IPAddress"

# Forward beszel port to your host machine
ssh -NL 8090:<container ip>:8090 username@server
```

Go to `http://localhost:8090`. Follow the [instruction](https://beszel.dev/guide/getting-started#_2-create-an-admin-user).

```
Name: vps
Host / IP: /beszel_socket/beszel.sock
```

Copy values from `Public Key` and `Token` fields to `.env` file (based on `.env.example` template)

Complete run

```sh
docker compose up -d
```
