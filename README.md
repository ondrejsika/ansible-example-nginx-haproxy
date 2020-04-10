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
./ping.sh
```

## Apply Playbooks

```
./apply.sh site.yml
```

## Destroy Infrastructure

```
terraform destroy -auto-approve
```
