This project demonstrates the end-to-end DevOps lifecycle for deploying a static HTML + CSS website.
It uses Jenkins for CI/CD automation, Docker for containerization, and Kubernetes (Minikube) for deployment.

The pipeline:

Pulls code from GitHub.

Builds a Docker image for the website.

Pushes the image to Docker Hub.

Deploys the container to a Kubernetes cluster (Minikube).

Exposes the app using a Kubernetes Service / Ingress.

🛠 Tech Stack
Version Control: Git, GitHub

CI/CD Tool: Jenkins

Containerization: Docker

Container Registry: Docker Hub

Orchestration: Kubernetes (Minikube)

Ingress Controller: Nginx

Scripting: Bash, kubectl

