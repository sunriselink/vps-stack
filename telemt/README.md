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

Get the users and links

```sh
./get-users.sh
```

Metrics

```sh
curl -s http://localhost:${METRICS_PORT}/metrics
```
