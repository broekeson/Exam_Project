Project Deployments
===================
Pre-requisites
--------------
- Digital Ocean Account
- Github Account
- Ansible

### Clone & fork the repository
```bash
git clone https://github.com/broekeson/Exam_Project.git
```
### Setup Jenkins Server
```bash
cd Exam_Project/Ansible
ansible-playbook localhost main.yml # This will setup Jenkins Server, terraform and the required plugins on the localhost
```
```
### Authenticate to Jenkins Server
```bash
# Login to Jenkins Server
http://<ip-address>:8080
# Get the authentication key
cat /var/lib/jenkins/secrets/initialAdminPassword
# Install the suggested plugins and create an admin user
```
### Install the required plugins
```bash
# Install the following plugins on Jenkins Server
- Kubernetes
- Docker
- Ansible
- Digital Ocean
- Terraform
```

### Setup Jenkins Credentials
```bash
# Create the following credentials on Jenkins Server
- Digital Ocean API Key
- Github Username and Password
- SSH Key
```

### Create a new pipeline job
```bash
# Create a new pipeline job
- Name: provisioning_cluster
- Pipeline: Pipeline script from SCM
- SCM: Git
- Repository URL: <<your-fork-repo-url>>
- Credentials: <<your-github-credentials>>
- Branches to build: */main
- Script Path: Jenkinsfile
```

### Run the pipeline job
```bash
# Run the pipeline job
- Click on the build now button
```
Sit back and relax while the pipeline job runs. It will take about 10 minutes to complete.

<br>
<br>

### Extras <br>
----------------
- Connect your domain to Digital Ocean Nameservers
- Customize 05-terraform variables.tf file
- Customize ingress-controller files

