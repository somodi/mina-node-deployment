Mina block producer bootstrap scripts
=====================================

## Introduction
This recipes will deploy an EC2 instance and set up a simple configuration of a mina block producer node.


## Set up local environment

This project uses docker, docker-compose, terraform and ansible

You may follow the appropriate installing instructions for your SO/distro.

e.g. for Ubuntu: 
- Docker: https://docs.docker.com/engine/install/ubuntu/
- Docker compose: https://docs.docker.com/compose/install/compose-plugin/
- Terraform: https://www.terraform.io/downloads
- Ansible: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

## How to deploy a machine

- Fill `terraform/terraform.tfvars` with your AWS credentials

e.g.: 

```
    my_access_key = "<MY_ACCESS_KEY>"
    my_secret_key = "<MY_SECRET_KEY>"
```

Add an EC2 key to your aws account, download it, and put it (or symlink it) in ansible/secrets/aws.pem

Run `make up`

Refer to [the mina documentation](https://docs.minaprotocol.com/en/using-mina/connecting) for more information.

## Local Nix development environment

The folder `nixos-docker-env` contains a first attempt to pack and deploy Mina in NixOS
It was done using this debian package: 
`https://packages.o1test.net/pool/focal/m/mi/mina-mainnet_1.3.1beta1-master-3e3abec.deb`
