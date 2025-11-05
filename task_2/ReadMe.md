# DevOps Task 2 - AWS IaC Автоматизация

## Description

This project tries to create automation for creating simple infrastructure on AWS, using Terraform, Ansible and Jenkins   
Includes:
- 1 Load Balancer
- 2 Web servers wit Nginx
- 1 MySQL DB

---

## ⚙️ Технологии

- **Terraform** – IaC - Creates the infrastructure on AWS
- **Ansible** – Configuration automation - for the web and db servers
- **Jenkins** – CI/CD pipeline for auto deployment
- **AWS Free Tier** is using 

---

## 🚀 Инструкции за стартиране

### Github Repo
https://github.com/nikkonix/digitall_tasks.git
### Working folder
task_2 
### Build Jenkins image with all we need
docker build -t jenkins-task2 .
### Start the Jenkins container
mkdir -p ~/jenkins_home
mkdir -p ~/jenkins_aws_keys
cp test-key.pem ~/jenkins_aws_keys/ # Need it key for provisioning the instances via Ansible
chmod 400 ~/jenkins_aws_keys/test-key.pem
docker run -d \
  --name jenkins \
  -p 8080:8080 -p 50000:50000 \
  -v ~/jenkins_home:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v ~/jenkins_aws_keys:/keys \
  --user root jenkins-task2         # Bring up the  Jenkins container 
### Obtain admin Jenkins password
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
### Connect and finish Jenkins setup
Open in browser  -> http://localhost:8080
### Install necessarry plugins from Jenkins UI
Git, Terraform, Ansible, Pipeline: AWS Steps, Pipeline Utility Steps
- Create both secrets AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY in Jenkins
- They will be used from the pipeline which dpeloys the infrastructure to AWS
- Create pipeline when Jenkins is ready pointing use the Jenkinsfile from jenkins folder 
- Trigger the pipeline

** P.S Not fully tested , part with ansible provisioning ssh connection does not work **

