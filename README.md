# FP-Jenkins
This Project aims to understand the idea o devops and piplines.

## Description
1. Creating infrastructure using terraform through jenkins pipeline
2. This pipline will trigger other pipeline that deploy application on created infrastructure
3.  The application will be a simple Hello application

## Getting Started
### Dependencies
- Docker
- Terraform
- Kubectl
- Jenkins

### How to use it
1. Apply terraform of Jenkins that will be in this repo

2. Preparing the work environment by runnig commands in script.sh file at this repo

3. Create your first pipeline using inrastructure [REPO](https://github.com/Abdelrhmxn/FP-IAC)

4. Create second Pipline using app [REPO](https://github.com/Abdelrhmxn/FP-APP)

5. Make application Pipline triggered by inrastructure pipline

6. Create a webhook for each push in the repo
