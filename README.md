# SRE/Devops Challenge

## Overview
This challenge involves deploying a Node.js application that monitors the Polygon blockchain's block height on Google Kubernetes Engine (GKE) using Terraform and CI/CD. The task will assess your skills in cloud infrastructure management, container orchestration, application deployment, monitoring, and automation.

## Prerequisites
- API Key from polygonscan.com (it is free)  https://polygonscan.com/register
- Get Access to Google Cloud Platform (GCP) and the claim $300 free credits
    https://cloud.google.com/free/docs/gcp-free-tier/#free-trial.
- Familiarity with Terraform, Kubernetes, Docker, Helm, Prometheus, Grafana, and GitHub Actions.

## Objectives
- Provision a GKE cluster in a dedicated VPC using Terraform.
- Containerize and deploy a provided Node.js application to GKE.
- Set up Prometheus and Grafana in the cluster for monitoring.
- Ensure the application and Grafana dashboard are publicly accessible.

## Task Details

### 1. GCP Project Setup
- Create a new project on GCP.
- Claim the $300 free credits.

### 2. Terraform Setup for GKE
- Use existing Terraform modules or create a minimal setup for provisioning a VPC and GKE cluster.
- Optionally, set up an IAM role for a read-only Kubernetes user.

### 3. Node.js Application Setup
- Fork or clone the [BCWResearch/HelloWeb3](https://github.com/BCWResearch/HelloWeb3) repository.
- Register for an API key from [PolygonScan](https://polygonscan.com/).
- Create a Dockerfile for the application.
- Set up a CI/CD pipeline with GitHub Actions for building and pushing the Docker image.

### 4. Helm Chart and Deployment
- Develop a Helm chart for the application.
- Deploy the application to GKE using CI/CD.
- Ensure public accessibility and metrics exposure on port 3000.

### 5. Prometheus and Grafana Deployment
- Deploy Prometheus in the GKE cluster.
- Deploy Grafana with external access (IP or DNS) and SSL.
- Configure Grafana for metrics visualization.

## Deliverables
- A GitHub repository with Dockerfile, Helm chart, CI/CD configuration, and Terraform code.
- Public URLs for the application and Grafana dashboard.
- Documentation on the setup process and access details.

## Evaluation Criteria
- Application deployment functionality.
- Metrics integration in Grafana.
- Best practices in Terraform, Kubernetes, monitoring, and CI/CD.
- Documentation quality.

### Deploying Prometheus and Grafana on your Kubernetes cluster"

This section guides you through the process of deploying both Prometheus and Grafana on your Kubernetes cluster. By following the provided instructions, you can set up robust monitoring and visualizations for your cluster using Prometheus to collect metrics and Grafana to create insightful dashboards for data visualization and analysis.

#### Installing Prometheus

This section provides instructions for installing Helm on either your deployment server or Linux client using the `snap` package manager. After Helm is installed, you can add the Prometheus Community repository using the helm repository add command, enabling you to access and install Prometheus using Helm charts from the repository.

* installing helm on your deployment server or your Linux client

```bash
snap install helm --classic

# Adding repository for prometheus
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

### Prometheus Configuration

This section provides a `YAML` configuration snippet and the corresponding Helm command to set up and deploy Prometheus with custom configurations. By modifying the `values.yaml` file to meet your specific requirements and executing the provided Helm command, you can install Prometheus in the desired namespace (`prometheus`) using the Prometheus Community Helm chart. This allows for flexible configuration of scrapes, including targets for both Prometheus itself (`localhost:9090`) and the application Exporter (`helloweb3.default.svc.cluster.local:80`), along with relabeling configurations for customization.

```yaml
extraScrapeConfigs: |
  - job_name: prometheus1
    static_configs:
    - targets:
      - localhost:9090


  - job_name: 'node'
    metrics_path: '/metrics'
    static_configs:
      - targets: ['helloweb3.default.svc.cluster.local:80']



```

And finally run the following command:

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm upgrade --install prometheus --values values.yaml \
     --namespace prometheus prometheus-community/prometheus \
     --kubeconfig=/etc/kubernetes/admin.conf -n prometheus --create-namespace
```


This section provides the necessary commands to install Grafana using Helm. By adding the `Bitnami` repository and upgrading the Grafana chart, you can easily deploy Grafana and begin visualizing and analyzing your Prometheus metrics in a Kubernetes environment.

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade -i  grafana -n prometheus bitnami/grafana ---values values.yaml
``
## Additional Resources
- Terraform, GitHub CI, and Helm references are provided in this repository to illustrate the basic structure. Feel free to modify these as needed.

## Submission Guidelines
- Ensure all deliverables are committed to your repository.
- Provide clear documentation in the repository.
- Submit the repository URL upon completion.

Good luck!
