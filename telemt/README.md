# Telemt

## Initial setup

Create a `config.user.toml` file with the following content

```toml
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

Get the links

```sh
curl -s http://localhost:9091/v1/users | jq
```
