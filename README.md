# Deploys ElasticSearch using Terraform - Features

## Integration with a Buildkite pipeline

Buildkite pipeline-as-code can be accessed from 
[here](https://github.com/devacto/estf/blob/master/.buildkite/pipeline.yml).

Below is the screenshot of the Buildkite pipeline that deploys this.

![bk_one](https://raw.githubusercontent.com/devacto/estf/master/docs/images/buildkite_screenshot_one.png)

![bk_two](https://raw.githubusercontent.com/devacto/estf/master/docs/images/buildkite_screenshot_two.png)

## Using Cloud Native Solutions

I have opted to use AWS Client VPN for their managed VPN service, and AWS 
Elasticsearch Service. Using managed solutions simplifies the deployment,
while leveraging AWS's best practices in maintaining Elasticsearch cluster.

Also, using AWS's managed Elasticsearch service ensures that upgrades of
Elasticsearch and making sure zero down time is handled by AWS.

If we were to use our own Elasticsearch setup scripts, we have to setup for
blue-green deployment to ensure zero down time.

![es_config](https://raw.githubusercontent.com/devacto/estf/master/docs/images/aws_es_config.png)

Increasing the number of instances can be done by increasing node count config
in the Terraform module. Zero downtime deployment would be taken care of.

## Elasticsearch inside Private Subnet

I have put our Elasticsearch inside private subnet, which makes it only
accessible through VPN.

This way, I can also configure that only certain IPs can access the VPN server.

Also, access to the VPN server is logged.

![vpn_log](https://raw.githubusercontent.com/devacto/estf/master/docs/images/vpn_connection_log_aws.png)

Screenshot below shows Kibana dashboard only accessible when I am connected
through our VPN.

![kibana](https://raw.githubusercontent.com/devacto/estf/master/docs/images/kibana_accessed_through_vpn.png)

## Terraform Modules

Code for this exercise is organised into Terraform modules to it reusable
and easily extensible.

Also, this helps us reduce repeating codes. (DRY principle)

## Uploading Buildkite secrets to AWS S3

To upload secrets to S3:
```
aws s3 cp \
  --acl private \
  --sse aws:kms \
  .aws/env \
  "s3://buildkite-managedsecretsbucket-4453l3nsab52/deploy-elasticsearch/env"
```

All secrets are managed using S3 and not visible in this repository.

## Built-in Monitoring by AWS

Screenshots below show monitoring by AWS Elasticsearch Service.

Important metrics to monitor since Elasticsearch is JVM based: memory.

![monitoring_one](https://raw.githubusercontent.com/devacto/estf/master/docs/images/es_monitoring_one.png)

![monitoring_two](https://raw.githubusercontent.com/devacto/estf/master/docs/images/es_monitoring_two.png)

## VPC and Network Setup using Terraform

Creation of the VPC and network setup for this exercise is done using Terraform.