# Complete Django Docker Stack
This stack is intended start development with Django as fast as possible.

## What does this stack have?
- Nginx SSL web server with SSL Support
- PostgreSQL Database server

## Setting up
### TL;DR
- Add following lines to your `.bashrc` or `.zshrc` file:
```bash
export UID=$(id -u)
export GID=$(id -g)
```
- Duplicate file `.env.example` to `.env`
- Setup variables in `.env` file
- Run `./docker/scripts/generate-certs.sh` in your terminal
- Run `docker composer up -d` to start the stack

### In Detail
The stack uses environment variables to setup the docker images. To set them up,
you need to create `.env` file and copy the contents from `.env.example` file.
Variable names are self explanatory but if you want to learn in detail, you can
check the [Environment Variables](#environment-varialbes) section.

We are using self signed certificates on nginx server to enable SSL path without
getting certificate errors. Run `./docker/scripts/generate-certs.sh` file to auto
generate certificates. The script will generate some files to `docker/certs` path.
`ca.crt` file is generated Certificate Authorith file and you need to install it
to your certificates. You can also use same `ca.*` files on your other Django
stacks. Just copy your `ca.key` and `ca.crt` files to same folder in other clones
and It will use same same key to create SSL certificates.

The defined domain should map to `127.0.0.1` in your `hosts` file.

One of the problems with docker is that created container uses root when editing
in files. This is especially the case with using docker in WSL2. Some dev containers
defining `1000:1000` user and usergroup themselves but python image we are using
don't. So it is essential to define same user inside container so that you don't
run into trouble with GIT.

## Environment Variables
### `DOMAIN`
Used by nginx web container's server name configuration and `generate-certs.sh` file.
You can choose any domain name you want but it is advised not to use an actual
exensions like `.com`. A good exension can be `.local` or `.lcl` if you want it
shorter.

### `DB_*`
Postgres database related variables. You can set them up however you want.

## TODO
- [x] Use environment variables
  - [ ] Add ability to modify exposed ports in env
- [x] Python container
  - [x] PIP requirements
    - [x] Django:latest
    - [x] gunicorn:latest
  - [-] PIP dev requirements
    - [x] Black
    - [x] Pylint
    - [x] isort
    - [x] pre-commit
    - [ ] ~~Flake8~~
  - [ ] Node LTS
    - [ ] Vite
    - [ ] eslint
    - [ ] prettier
    - [ ] react
    - [ ] react-dom
