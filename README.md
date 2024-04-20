# tf-az-aks-poc
Terraform scripts for provisioning AKS clusters and deploying a HelloWorld app.


# Project Name

## Overview

This project contains Terraform scripts to provision an Azure Kubernetes Service (AKS) cluster, along with GitHub Actions pipelines for CI/CD and Kubernetes manifests for deploying applications to the AKS cluster.

## Project Structure

- `tf-az-aks-poc/`: Contains Terraform scripts for provisioning the AKS cluster.
- `k8s/`: Contains Kubernetes manifests for deploying applications to the AKS cluster.
- `tf-cicd.yaml`: GitHub Actions pipeline for Terraform CI/CD.
- `aks-cicd.yaml`: GitHub Actions pipeline for AKS CI/CD.
- Other files and directories for additional code (e.g., backup, ACR, AKS extensions). They are under `aks/` , `aks-acr/` , `aks-backup/` folders for future enhancement.

## Usage

1. Clone the repository:

    ```bash
    git clone <repository_url>
    ```

2. Navigate to the project directory:

    ```bash
    cd <project_directory>
    ```

3. Set up required credentials and configurations (e.g., Azure credentials).

4. Run the Terraform scripts to provision the AKS cluster:

    ```bash
    cd ./
    terraform init
    terraform plan
    terraform apply
    ```

5. Deploy applications to the AKS cluster using Kubernetes manifests:

    ```bash
    kubectl apply -f k8s/
    ```

## GitHub Actions

- `terraform-cicd.yaml`: CI/CD pipeline for Terraform scripts.
- `aks-cicd.yaml`: CI/CD pipeline for AKS deployment.

## Additional Code

- Additional code (e.g., backup scripts, Azure Container Registry configurations, AKS extensions) can be found in the repository and integrated into the CI/CD pipelines as needed.

## <font color = "red"> Follow-Me </font>

[![Portfolio](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/premkumar-palanichamy)

<p align="left">
<a href="https://linkedin.com/in/premkumarpalanichamy" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="premkumarpalanichamy" height="25" width="25" /></a>
</p>

[![youtube](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/channel/UCJKEn6HeAxRNirDMBwFfi3w)