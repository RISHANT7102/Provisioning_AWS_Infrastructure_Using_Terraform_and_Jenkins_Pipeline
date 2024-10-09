# Provisioning AWS Infrastructure Using Terraform and Jenkins Pipeline

Overview
-
This project demonstrates how to provision AWS infrastructure using Terraform in combination with a Jenkins pipeline. It creates a Virtual Private Cloud (VPC), subnet, S3 bucket, security group, RSA key pair, and an EC2 instance.

Prerequisites:
-
Before you get started, ensure you have the following:
•	An AWS account.
•	An EC2 instance with Jenkins, Terraform, and Git installed and configured.
•	IAM user with sufficient permissions to create the resources defined in the Terraform scripts.

Terraform Configuration
-
main.tf File:
This file contains the Terraform configuration to provision the following AWS resources:
•	VPC: A Virtual Private Cloud to host your resources.
•	Subnet: A subnet within the VPC.
•	S3 Bucket: An S3 bucket for storage.
•	Security Group: A security group to allow SSH access.
•	Key Pair: An RSA key pair for secure access to EC2 instances.
•	EC2 Instance: A t2.micro instance running in the created subnet.

Variables:
You need to define the following variable in a variables.tf file or pass it directly during execution and the 
name of the key pair you want to create. This should be specified in your terraform.tfvars

Jenkins Pipeline
-

Jenkinsfile:
The Jenkins pipeline automates the following stages:
1.	Git Checkout: Pulls the latest code from the GitHub repository.
2.	Terraform Init: Initializes Terraform and downloads the necessary provider plugins.
3.	Terraform Plan: Creates an execution plan, showing what Terraform will do.
4.	Terraform Apply/Destroy: Applies the Terraform configuration or destroys the resources based on user input.

Parameters:
-
•	ACTION: Choose between Apply to create the resources or Destroy to delete them.

How to Use:
-
1.	Configure Jenkins:
a.  Set up a new pipeline job in Jenkins.
b.	Point it to your Git repository.
c.	Ensure that Jenkins has the necessary IAM permissions to access AWS resources.
   
2.	Run the Pipeline:
a.	Trigger the Jenkins job.
b.  Select Apply to provision resources or Destroy to tear them down.





