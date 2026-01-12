# SimpleMicroservice
Simple application to learn microservices workflow. 

## Architecture
The system is composed of two main services communicating over a private cluster network:

Frontend (Python/Flask): Serves the UI, handles user input, and aggregates data from the backend.

Backend (Python/Flask): Provides standard greeting logic and a "secret" message endpoint for authorized names.

## Deployment options

### Open Nebula deployment using Docker Compose
Uses Terraform to create a VM on OpenNebula. Then uses Ansible to setup Docker on that VM and deploys the application using Docker Compose. The application is then available at the public IP address of the VM on port 8080.

### Kubernetes deployment
Uses kubectl to deploy the application to a Kubernetes clustern (locally on Minikube). Sets up deployment and service objects for frontend and backend as well as an Ingress object. If using Minikube and tunnel is active, application is then available locally at `localhost:8080`.

## Prerequisities
- Python
- Docker
- Terraform
- Ansible
- Kubernetes cluster (Minikube)
- kubectl

## Usage
For simple usage, bash scripts are created for both deployment and cleanup for both types of deployment. 

To deploy an application to Open Nebula, use (from repositorty root directory):
```
./scripts/deploy-one.sh
```
This will perform all necessary steps to deploy and start the application. To then clean up created node, run:
```
./scripts/cleanup-one.sh
```

For Kubernetes (Minikube) deployment use the scripts `deploy-k8s.sh` and `cleanup-k8s.sh` in the same way. Another command - `minikube tunnel` is needed for the running application to be available.

### Terraform variables
During Open Nebula deployment, some private variables are necessary to access Open Nebula and created VM. Terraform will ask for these each time when running the scripts. To skip asking each time, the scripts support loading these varibles from an `.env` file. Simply copy the file `.env-example` as `.env` in the repository root directory and assign values to the varibles.

The variables are:
`one_username` - username for accesing Open Nebula API
`one_password` - Open Nebula access token
`ssh_privkey_path` - path to your ssh private key - used by Terraform to connect to the created VM for some basic provisioning. This key also needs to be added to ssh-agent for Ansible provisioning to work.
`ssh_pubkey_path` - path to your ssh public key - gets copied to `.ssh/authorized_keys` on the VM to access it.
