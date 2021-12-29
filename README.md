# DevOpsChallenge

This repo contains the infrastructure to host a scalable website.

The infrastructure utilises AWS resources to host the website, along with the use of Docker containers.

An Nginx docker image was built with a custom HTML, and stored in Elastic Container Registry (ECR).

The website is hosted using Elastic Container Service (ECS), pulling the latest image in ECR. An Application Load Balancer (ALB) within a Virtual Private Cloud (VPC) with 3 public subnets in 3 availability zones has been deployed for high availability. A health check has been created for the ALB to traffic is only routed to the heathly targets.

The Fargate launch configuration was chosen to reduce the management of EC2 instances.

## Scaling
The scalability for this website is achieved by using autoscaling to increase or decrease the desired count of tasks in the ECS service. The trigger for this is if the CPU or the Memory consumption increases to above 80%. This is currently configured to reach a max task size of 10.

## Security
Security groups have been configured for the ALB and for the ECS instances. Only inbound traffic to port 80 is allowed on the ALB and then subsequently, the container instances.

## Automation
A GitHub Actions deployment pipeline has been created to implement CI/CD practices. On creation of a PR to the main branch, a workflow is automatically triggered to format, initialise, and validate the code. A plan is subsequently generated and posted as a comment on the PR.
Once the PR has been merged, this triggers the apply.