# Ansible Server Bootstrap

Ansible playbooks for initial VPS server configuration.

## Setup

Create files that are not stored in the repository:

### `inventory.yml`

```yml
all:
  hosts:
    server1:
      ansible_host: <server1 ip>
    server2:
      ansible_host: <server2 ip>
    serverN:
      ansible_host: <serverN ip>
```

### `group_vars/all.yml`

```yml
user: '<username>'
user_password: '<password hash>'

user_ssh_public_key: '<ssh public key>'
user_ssh_private_key_path: '<ssh private key path on host machine>'

ssh_port: <custom ssh port>
```

Generate a SHA-512 password hash with OpenSSL:

```bash
openssl passwd -6
```

Generate an Ed25519 SSH key pair on the host machine:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/<key filename>
```

An SSH private key is mounted into the Ansible Docker container from the host's `$HOME/.ssh` directory. Therefore, `user_ssh_private_key_path` must point to the key inside the container. For example, if the host has `$HOME/.ssh/ansible_key`, use:

```yml
user_ssh_private_key_path: '~/.ssh/ansible_key'
```

## Run

Initial server setup:

```bash
./ansible-docker.sh ansible-playbook -i inventory.yml bootstrap.yml --ask-pass
```

The first play connects as `root` on port `22`. After SSH configuration is applied, the second play reconnects using the new user, SSH port, and private key.

## Run a single role

After `bootstrap.yml` has completed successfully, you can run any individual role:

```bash
./ansible-docker.sh ansible-playbook -i inventory.yml run.yml -e role=<role name>
```
