# Terraform AWS, Debezium, proxySQL and TiDB

 Deploy Debezium and Kafka to perform ongoing change data capture (CDC) from your existing mysql/mariadb database to populate tiDB. Then use ProxySQL to allow you to test the features and performance of TiDB alongside your existing mySQL or MariaDB database. Write data to one database and read from the other.

![Debezium, proxySQL and TiDB Diagram](files/tiDB.png "Debezium, proxySQL and TiDB Diagram")

## Requirements

To deploy this project you will need:

* An [AWS account](https://aws.amazon.com/free/)
* [Packer](https://www.packer.io/) (tested on v1.8.5)
* [Terraform](https://www.terraform.io/) (tested on v1.4.2)
* [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/index.html) ( tested on v2.14.2)

## Step 1 of 4 - Create the Debezium and ProxySQL AMIs using Packer

```
cd packer

# validate files
packer validate --var-file=variables.json proxysql_instance.json
packer validate --var-file=variables.json debezium_instance.json

# build AMIs
packer build --var-file=variables.json proxysql_instance.json
packer build --var-file=variables.json debezium_instance.json
```

## Step 2 of 4 - Deploy the infrastructure using Terraform

```
terraform init
terraform apply
```

Once the infrastructure is in place the next step is to use Ansible to configure ProxySQL and also Debezium.

## Step 3 of 4 - Configure ProxySQL using the Ansible playbook

```
cd ansible

# Check the ansible playbook
ansible-playbook playbook.yml -i hosts --syntax-check

# Run the ansible playbook
ansible-playbook playbook.yml -i hosts
```

## Step 4 of 4 - Configure Debezium using the Ansible playbook

```
cd ansible

# Check the ansible playbook
ansible-playbook playbook.yml -i hosts --syntax-check

# Run the ansible playbook
ansible-playbook playbook.yml -i hosts
```


## Estimated monthly costs

(Powered by Infracost)

```
Project: gordonmurray/terraform_aws_debezium_proxysql_tidb

 Name                                                             Monthly Qty  Unit                    Monthly Cost

 aws_cloudwatch_log_group.kafka_broker_logs
 ├─ Data ingested                                           Monthly cost depends on usage: $0.57 per GB
 ├─ Archival Storage                                        Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned                           Monthly cost depends on usage: $0.0057 per GB

 aws_db_instance.default
 ├─ Database instance (on-demand, Single-AZ, db.t4g.micro)                730  hours                         $12.41
 ├─ Storage (general purpose SSD, gp2)                                     20  GB                             $2.54
 └─ Additional backup storage                               Monthly cost depends on usage: $0.095 per GB

 aws_instance.debezium
 ├─ Instance usage (Linux/UNIX, on-demand, t4g.small)                     730  hours                         $13.43
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                 100  GB                            $11.00

 aws_instance.proxysql
 ├─ Instance usage (Linux/UNIX, on-demand, t4g.small)                     730  hours                         $13.43
 └─ root_block_device
    └─ Storage (general purpose SSD, gp2)                                  50  GB                             $5.50

 aws_kms_key.cloudwatch_key
 ├─ Customer master key                                                     1  months                         $1.00
 ├─ Requests                                                Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests

 aws_kms_key.kafka_key
 ├─ Customer master key                                                     1  months                         $1.00
 ├─ Requests                                                Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests

 aws_kms_key.rds_key
 ├─ Customer master key                                                     1  months                         $1.00
 ├─ Requests                                                Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests

 aws_kms_key.secrets_manager
 ├─ Customer master key                                                     1  months                         $1.00
 ├─ Requests                                                Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                        Monthly cost depends on usage: $0.10 per 10k requests

 aws_msk_cluster.kafka
 ├─ Instance (kafka.t3.small)                                           2,190  hours                        $109.28
 └─ Storage                                                               150  GB                            $16.50

 aws_secretsmanager_secret.example
 ├─ Secret                                                                  1  months                         $0.40
 └─ API requests                                            Monthly cost depends on usage: $0.05 per 10k requests

 aws_secretsmanager_secret.msk
 ├─ Secret                                                                  1  months                         $0.40
 └─ API requests                                            Monthly cost depends on usage: $0.05 per 10k requests

 OVERALL TOTAL                                                                                              $188.90
──────────────────────────────────
30 cloud resources were detected:
∙ 11 were estimated, 6 of which include usage-based costs, see https://infracost.io/usage-file
∙ 19 were free:
  ∙ 8 x aws_security_group_rule
  ∙ 4 x aws_security_group
  ∙ 2 x aws_secretsmanager_secret_version
  ∙ 1 x aws_db_option_group
  ∙ 1 x aws_db_parameter_group
  ∙ 1 x aws_db_subnet_group
  ∙ 1 x aws_key_pair
  ∙ 1 x aws_msk_configuration
```

## Security

(powered by TFsec)

```
  results
  ──────────────────────────────────────────
  passed               42
  ignored              0
  critical             1
  high                 1
  medium               0
  low                  1

  42 passed, 3 potential problem(s) detected.

* Result #1 CRITICAL Security group rule allows egress to multiple public internet addresses.
* Result #2 HIGH Cluster allows plaintext communication.
* Result #3 LOW Instance does not have performance insights enabled.
```
