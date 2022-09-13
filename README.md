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

## Dowload roles from Ansible Galaxy

```
ansible-galaxy install ahuffman.resolv
```

## Apply Playbooks

```
ansible-playbook site.yml
```

See:

- http://proxy.sikademo.com
- http://web0.sikademo.com
- http://web1.sikademo.com

## Destroy Infrastructure

```
terraform destroy -auto-approve
```
