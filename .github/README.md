# Medusa Backend on AWS ECS (Fargate)

This project deploys a Medusa.js backend using Docker, Terraform, and ECS Fargate on AWS.

## Stack
- Medusa.js (Headless commerce)
- Docker
- AWS ECS + Fargate
- RDS PostgreSQL
- ECR
- Application Load Balancer
- GitHub Actions for CI/CD

## How to Deploy

1. Clone this repo
2. Set up AWS credentials
3. Push to `main` branch to trigger GitHub Actions
4. Terraform provisions all infra + Docker pushes the app to ECS

## Author

Vaibhav Sarkar🎓
