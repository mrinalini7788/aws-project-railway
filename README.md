
### Project Architecture: 

![Railway-Ticket-Booking-Application-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/af783756-252a-4ad4-9f03-d44731db7927)


**Deploying Railway Ticket Booking Application on AWS EKS using modern DevOps tools and best practices. This Project Showcases the deployment of frontend and backend microservices on AWS (Elastic Kubernetes Service). fully automated using Jenkins pipelines, Helm, Argocd and Terraform.**


### Project Overview:

we've build a **Two-Tier web application** where:

- User input details (Name, Source, Destination, Food Preference) via the **frontend**.

- Data is securely sent to the **backend** and stored in an **AWS RDS MySQL database**.
  


### Architecture Highlights:

- **2 GitHub Repositories:**

    - 1. Contains **frontend & backend app code + Terraform** scripts for AWS infrastructure.
 
    - 2. Contains **Helm Charts** for the EKS deployments.
     
```
https://github.com/vijaygiduthuri/aws-2-tier-helm-chart.git
```



- Fully automated CI/CD using **Jenkins pipelines**.

- Infrastructure-as-code with **Terraform**

- Continuous delivery with **Argocd**
- <img width="1702" height="351" alt="Screenshot 2026-02-02 at 10 58 37 AM" src="https://github.com/user-attachments/assets/6bb10561-4a13-425e-8f81-f6e4c523b34e" />


- Domain setup via **GoDaddy** and secure HTTPS access with **TLS certificates**.


### Jenkins Pipeline Overview:

**Pipeline 1 -> Application CI/CD:**

- Pulls app source code from GitHub.

- Performs static code analysis using **SonarQube**.

- Scans dependencies with **OWASP Dependency-Check**.

- Builds Docker Image for **frontend & backend** and pushes them to **AWS ECR**

- Runs **Trivy** scans on Docker images for vulnerabilities.

- Clones Helm Chart repo and updated image tags dynamically.
- <img width="1690" height="421" alt="Screenshot 2026-02-01 at 5 03 34 PM" src="https://github.com/user-attachments/assets/4f09079d-7b50-4063-beaf-b74e573d92e2" />



**Pipeline 2 -> Infrastructure Provisioning:**

- provisions full AWS infrastructure using **Terraform:** "VPC, Subnets, Route Tables, IGW's, EC2 (Ubuntu Jumpbox), RDS(MySQL), and EKS Cluster."

- Install **Argocd** on **EKS** and integrates **Helm Chart Repo.**

- Install **Nginx Ingress Controller** and maps the Load Balancer DNS to a **Godaddy Domain**.

- Secures the domain with **TLS/HTTPS** using **cert-manager**.
<img width="1033" height="545" alt="Screenshot 2026-02-01 at 5 05 01 PM" src="https://github.com/user-attachments/assets/e92d9566-8b50-488b-a4b9-42ec3413e046" />


### Final Output:

- A fully deployed Railway Ticket Booking app accessible via a custom domain over HTTPS, running on scalable kubernetes infrastruture on AWS!


<img width="1919" height="828" alt="Screenshot 2025-07-16 162354" src="https://github.com/user-attachments/assets/15005bfb-738a-4e5b-baad-0302987477d0" />




---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

**1. Create AWS Infra using Terraform: VPC, EC2, EKS, RDS**

**2. Connect to EC2 ( jump-server ) & Install kubectl, helm, awscli  -> after provide aws creds on ec2 using "aws configure"**

**3. update RDS Endpoint on K8s -> backend-deployment.yaml -> DB_HOST**

**4. Create 2 ECR Repositorys Manually:  1. frontend-repo,   2. backend-repo**

  - Now build frontend & backend Docker images and push to AWS ECR Repos:

  - login to AWS ECR

```
cd frontend
docker build -t frontend:latest .
docker tag frontend:latest 657001761946.dkr.ecr.us-east-1.amazonaws.com/frontend-repo:latest
docker push 657001761946.dkr.ecr.us-east-1.amazonaws.com/frontend-repo:latest

cd ../backend
docker build -t backend:latest .
docker tag backend:latest 657001761946.dkr.ecr.us-east-1.amazonaws.com/backend-repo:latest
docker push 657001761946.dkr.ecr.us-east-1.amazonaws.com/backend-repo:latest
```

**5. Update Images on "K8s yamls" and also provide "rds database credentails" on backend-deployment.yaml & apply them**

```
cd k8s
kubectl apply -f .
```

  - check "frontend & backend service are running or not"

```
kubectl get all
```

**6. access "frontend ui" using "LoadBalancer" DNS Name & provide inputs like "Name, Travelling from, Destination, Food Preference" & check all the data on "backend"**

<img width="1919" height="828" alt="Screenshot 2025-07-16 162354" src="https://github.com/user-attachments/assets/15005bfb-738a-4e5b-baad-0302987477d0" />



  - connect to ec2 ( jump server ) & Install MySQL and check your data:

```
sudo apt install -y mysql-client
mysql -h <RDS-endpoint> -u railway -p
```

  - Example:

```
mysql -h my-rds-instance.ce9wya4k41zv.us-east-1.rds.amazonaws.com -u vijay -p
password: Password123

show databases;
use appdb;
show tables;
select * from bookings;
```
<img width="499" height="97" alt="Screenshot 2026-02-02 at 12 33 10 PM" src="https://github.com/user-attachments/assets/f88e4f3f-9a5c-4b2d-8144-62fc6fd554f1" />



**7. To Destroy entire resources:**

```
terraform destroy --auto-approve
```
