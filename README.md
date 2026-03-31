

##  Jenkins on AWS with Terraform & Docker

This project provisions a Jenkins CI/CD server on AWS using Terraform. Jenkins runs inside a Docker container on an EC2 instance, with an attached EBS volume for persistent storage. The setup is automated via a shell script and ready for production use.

---

### What’s Included

- **Terraform Infrastructure**  
  - EC2 instance (Ubuntu)  
  - EBS volume mounted at `/var/jenkins_home`  
  - Security Group with port 8080 open  
- **Dockerized Jenkins**  
  - Jenkins runs inside a container  
  - Persistent data stored on EBS  
- **Setup Script**  
  - Mounts EBS  
  - Fixes permissions  
  - Runs Jenkins container  
- **Architecture Diagram**  
  - Visual overview of the setup

---

### Architecture

`[Looks like the result wasn't safe to show. Let's switch things up and try something else!]`

---

### Setup Instructions

#### 1. Clone the Repo
```bash
git clone https://github.com/your-username/jenkins-aws-terraform.git
cd jenkins-aws-terraform
```

#### 2. Configure Terraform
Edit `terraform/variables.tf` with your desired region, key pair name, and instance type.

#### 3. Deploy Infrastructure
```bash
cd terraform
terraform init
terraform apply
```

#### 4. SSH into EC2 & Run Setup
```bash
ssh -i <your-key>.pem ubuntu@<public-ip>
chmod +x scripts/setup-jenkins.sh
./scripts/setup-jenkins.sh
```

#### 5. Access Jenkins
Open in browser:
```
http://<public-ip>:8080
```
Get admin password:
```bash
sudo docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
```

---

### File Structure

```
jenkins-aws-terraform/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── provider.tf
├── scripts/
│   └── setup-jenkins.sh
└── README.md
```

---

### 🛡️ Security Tips

- Assign an Elastic IP to your EC2 instance  
- Restrict port 8080 to trusted IPs in the security group  
- Use HTTPS with Nginx + Let’s Encrypt for secure access


