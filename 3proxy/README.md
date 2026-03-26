# 3proxy

## Initial setup

Create `.env` file based on `.env.example` template and fill missing variables

Create required resources

```sh
# Logs folder
mkdir -p logs
chmod 700 logs

# Users data
touch .3proxypasswd
chmod 600 .3proxypasswd
```

Add users to `.3proxypasswd` file

```
john:CL:<john_password>
mike:CL:<mike_password>
```

Run proxy

```sh
docker compose up -d
```
