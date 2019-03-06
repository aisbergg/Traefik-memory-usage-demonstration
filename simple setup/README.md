# Traefik memory usage demonstration
This repository is only for demonstration purposes. It contains a Vagrant setup for spinning up a simple test environment to tackle the bug issued here: https://github.com/containous/traefik/issues/4474 .

## Create the test environment
To use this setup the following two tools are required:
- [VirtualBox](https://www.virtualbox.org)
- [Vagrant](https://www.vagrantup.com)

To spin up the VM the command `vagrant up` needs to be run inside this repository where the `Vagrantfile` is located. This might take a while but that is all that needs to be done.

## Provoke high memory usage issue with Traefik

Log into the VM using `vagrant ssh`. There are two important services running, one is a dummy webserver and the other one is Traefik. Traefik is configured to serve two different sites, one of those has custom error pages defined on them.

Now you can fake downloading large files from the first webservice:
```sh
while true; do curl -s -H 'Host: without-errorpages.dev.local' http://127.0.0.1/big-file -o /dev/null ; done
```

Let it run for a while before killing the process with Ctrl-C. If you then check Traefiks memory usage with `htop` you will see that everything is fine.

On the other hand downloading large files from the webservice that has custom error pages defined you will notice Traefik to go haywire:
```sh
while true; do curl -s -H 'Host: with-errorpages.dev.local' http://127.0.0.1/big-file -o /dev/null ; done
```
