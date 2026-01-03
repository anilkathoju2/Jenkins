**This covers:**

Jenkins installation

Java version handling

Docker installation

Making the node usable as a Jenkins Docker agent

Jenkins Master + Docker Agent Setup (RHEL 9 / EC2)

This guide installs Jenkins and Docker on a RHEL 9–based EC2 instance and prepares it to run Jenkins jobs using Docker.

**Prerequisites**

RHEL 9 / Amazon EC2

Root or sudo access

Open port 8080 in Security Group

Internet access
---
1. Update System
sudo dnf clean all
sudo dnf update -y

2. Install Java (Required for Jenkins)

Jenkins requires Java 17 on RHEL 9.

⚠️ Java 21 is not supported by Jenkins LTS at this time.

sudo dnf install -y java-17-openjdk


Verify:

java -version

**3. Add Jenkins Repository**

**Remove any broken repo (if exists)**

sudo rm -f /etc/yum.repos.d/jenkins.repo

**Add Jenkins repo using curl (recommended)**

sudo curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.repo \
  -o /etc/yum.repos.d/jenkins.repo


**Verify:**
ls -l /etc/yum.repos.d/jenkins.repo


**Import the Jenkins GPG key (important)**
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key




Refresh metadata

sudo dnf clean all

sudo dnf makecache

**Continue Jenkins installation (correct order)**
sudo dnf upgrade -y
sudo dnf install -y fontconfig java-21-openjdk
sudo dnf install -y jenkins
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

jenkins --version
sudo systemctl status jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
**7. Access Jenkins UI**

**Open in browser:**

http://<EC2_PUBLIC_IP>:8080


**Get initial admin password:**

sudo cat /var/lib/jenkins/secrets/initialAdminPassword

**8. Install Docker (Jenkins Agent Requirement)**

**Docker must be installed from the official Docker repo.**
**Remove old Docker packages (safe)**

sudo dnf remove -y docker docker-client docker-common docker-latest \
docker-latest-logrotate docker-logrotate docker-engine

**Install required plugin**
sudo dnf install -y dnf-plugins-core

**Add Docker CE repository**

sudo dnf config-manager --add-repo \
https://download.docker.com/linux/rhel/docker-ce.repo


**Install Docker Engine**
sudo dnf install -y docker-ce docker-ce-cli containerd.io

**9. Start and Enable Docker**

sudo systemctl enable docker

sudo systemctl start docker

**logout** & **login**

**Verify:**

docker version
docker run hello-world

**10. Allow Jenkins & Users to Run Docker (IMPORTANT)**

**Add users to Docker group:**

sudo usermod -aG docker ec2-user
sudo usermod -aG docker jenkins

**Restart docker service**  
sudo systemctl restart docker



**Restart Jenkins to apply permissions:**

sudo systemctl restart jenkins
