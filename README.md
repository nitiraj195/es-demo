# Elasticsearch Cluster Automation

The script can be used to get launch a Elasticsearch cluster in production

**Requirements**
- Install terraform
- Install ansible

**Steps**
- Create a copy of vars file inside env folder with name equals to the environment name
- Now run the deploy.sh with appropriate command and the env name
    
Command: `./deploy.sh`

This will create the elasticsearch cluster

**Tfvars Arguments:**
Following arguments are available:

- name (required) : Name of the elasticsearch cluster
- key_name (required): Name of the pem key file to use for instances
- subnet_id (required): Subnet Id in which you are planning to launch the instance
- access_cidr(required): List of CIDR block that will access the elasticsearch cluster
- region(required): The id for region where the elasticsearch cluster will be launched
- env(optional): Name of the env where you are launching. Defaults to prod
- bucket(required): Name of s3 bucket to store the state
- key(required): Name of the folder/state file. Example: terraform/tfstate
