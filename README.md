# Ansible Example: Simple Nginx & HAProxy Webserver

    2020 Ondrej Sika <ondrej@ondrejsika.com>
    https://github.com/ondrejsika/ansible-example-nginx-haproxy

## Run Infrastructure

```
terraform init
terraform plan
terraform apply -auto-approve
```

## Check Connection to Servers

```
ansible all -m ping
```

## Apply Playbooks

```
ansible-playbook site.yml
```

## Destroy Infrastructure

```
terraform destroy -auto-approve
```
