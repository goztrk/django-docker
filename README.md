# Complete Django Docker Stack
This stack is intended start development with Django as fast as possible.

## What does this stack have?
- Nginx SSL web server with SSL Support
- PostgreSQL Database server

## Setting up
### TL;DR
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
- [x] Nginx container
  - [x] Self signed SSL Certificates
- [x] PostgreSQL container
- [ ] Python container
  - [ ] Automatic Django setup
  - [ ] gunicorn setup
  - [ ] PIP requirements
    - [ ] Django:latest
    - [ ] gunicorn:latest
  - [ ] PIP dev requirements
    - [ ] Black
    - [ ] Flake8
    - [ ] pre-commit
  - [ ] Node LTS
    - [ ] Vite
    - [ ] eslint
    - [ ] prettier
    - [ ] react
    - [ ] react-dom
