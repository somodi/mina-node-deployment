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

Add an EC2 key to your aws account, download it, and put it (or symlink it) in `ansible/secrets/aws.pem`

Run `make init` to initialize terraform. then `make up` to run terraform and ansible recipes.

Refer to [the mina documentation](https://docs.minaprotocol.com/en/using-mina/connecting) for more information.
