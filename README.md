# GroceryMate 🛒

**GroceryMate** is a modern, full-featured e-commerce platform for seamless online grocery shopping.  
Built with Python and PostgreSQL, deployed on AWS using EC2, RDS, S3, and Terraform for infrastructure management.

---

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Prerequisites](#prerequisites)
4. [Installation](#installation)
5. [Usage](#usage)
6. [AWS Infrastructure](#aws-infrastructure)
7. [Terraform Deployment](#terraform-deployment)
8. [Environment Variables](#environment-variables)
9. [Contributing](#contributing)

---

## Overview
GroceryMate allows users to browse products, manage shopping baskets, and complete purchases securely and efficiently.  
This project demonstrates full-stack development with Python and PostgreSQL, integrated with AWS services for scalability and reliability.

---

## Features
- 🛡️ User authentication & protected routes
- 🔎 Product search & filtering
- ⭐ Favorites management
- 🛍️ Shopping basket
- 💳 Checkout process

---

## Prerequisites
- Python >= 3.11
- PostgreSQL
- Git

---

## Installation

### Clone the repository
```bash
git clone --branch version2 https://github.com/AnasSardarzai/AWS_grocery.git
cd AWS_grocery/backend
```

### Install Python dependencies
```bash
pip install -r requirements.txt
```

### Configure PostgreSQL (local)
```bash
psql -U postgres -c "CREATE DATABASE grocerymate_db;"
psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_secure_password>';"
psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"
psql -U grocery_user -d grocerymate_db -f backend/app/sqlite_dump_clean.sql
```

### Environment variables
```bash
cp .env.example .env
```

Fill in your PostgreSQL credentials and `JWT_SECRET_KEY`.

---

## Usage
- Open: http://localhost:5000  
- Register / Login  
- Browse and search products  
- Add items to basket and checkout  

---

## AWS Infrastructure
This project uses the following AWS resources:

- **EC2** – Hosts the backend server
- **RDS (PostgreSQL)** – Stores user and product data
- **S3** – Stores user avatars and static assets
- **Security Group** – Allows HTTP (80) and SSH (22)
- **Terraform** – Provisions all infrastructure

### Terraform Outputs
- `ec2_public_ip` – Backend server access
- `rds_endpoint` – Database connection endpoint

---

## Terraform Deployment
```bash
cd infrastructure
terraform init
terraform plan
terraform apply
```

Use the Terraform outputs to update your `.env` file.

---

## Environment Variables
```env
JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
```

---

## Contributing
1. Fork the repository  
2. Create a feature branch  
3. Commit your changes  
4. Open a Pull Request  
