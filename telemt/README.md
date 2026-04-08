# Telemt

## Initial setup

Create `.env` file based on `.env.example` template and fill missing variables

Create a `config.user.toml` file with the following content

```toml
[general.links]
public_host = "<server ip>"

[censorship]
tls_domain = "<TLS domain for fake TLS handshake profile>"
mask = true
tls_emulation = true
tls_front_dir = "tlsfront"

[access.users]
john = "32-hex secret"
mike = "32-hex secret"
```

To generate a secret, use the command

```sh
openssl rand -hex 16
```

Run Telemt

```sh
docker compose up -d
```

## Telemt Panel

Forward port to your host machine

```sh
ssh -NL <host port>:127.0.0.1:<panel port> username@server
```

Go to `http://localhost:<host port>`. Login/password: `admin:admin` (see [config](./config.panel.toml))

## Additiona info

Get users info (short by default)

```sh
./get-users.sh [full]
```

Metrics

```sh
source .env
curl -s http://localhost:${METRICS_PORT}/metrics
```
