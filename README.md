# GroceryMate 🛒

**GroceryMate** is a modern, full-featured e-commerce platform for seamless online grocery shopping.  
Built with Python and PostgreSQL, deployed on AWS using EC2, RDS, S3, and Terraform for infrastructure management.

---

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Screenshots & Demo](#screenshots--demo)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [AWS Infrastructure](#aws-infrastructure)
8. [Terraform Deployment](#terraform-deployment)
9. [Environment Variables](#environment-variables)
10. [Contributing](#contributing)
11. [License](#license)

---

## Overview
GroceryMate allows users to browse products, manage shopping baskets, and complete purchases securely and efficiently.  
This project demonstrates full-stack development with Python and PostgreSQL, integrated with AWS services for scalability and reliability.

---

## Features
- 🛡️ **User Authentication & Protected Routes**: Secure registration, login, and session management.
- 🔎 **Product Search & Filtering**: Browse products, apply filters, and sort by category or price.
- ⭐ **Favorites Management**: Save and manage preferred products.
- 🛍️ **Shopping Basket**: Add, view, modify, and remove items.
- 💳 **Checkout Process**: Secure billing and shipping information handling with multiple payment options.

---

## Screenshots & Demo
![Homepage](path_to_homepage_image)  
![Product Page](path_to_product_page_image)  
[Demo Video](link_to_demo_video)

*(Replace the placeholder paths with actual images or video links from your repo.)*

---

## Prerequisites
Before running the application, ensure the following dependencies are installed:
- Python >= 3.11
- PostgreSQL (Database for storing products and users)
- Git

---

## Installation
```bash
# Clone the repository
git clone --branch version2 https://github.com/AnasSardarzai/AWS_grocery.git
cd AWS_grocery/backend

# Install Python dependencies
pip install -r requirements.txt

# Configure PostgreSQL
psql -U postgres -c "CREATE DATABASE grocerymate_db;"
psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_secure_password>';"
psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"
psql -U grocery_user -d grocerymate_db -f backend/app/sqlite_dump_clean.sql

# Create .env file (do not commit it!)
cp .env.example .env
# Fill in your JWT_SECRET_KEY and PostgreSQL credentials
Usage
Open http://localhost:5000

Register/Login to your account

Browse and search for products

Add items to your basket and proceed through checkout

AWS Infrastructure
This project uses AWS resources for hosting, storage, and database management:

EC2: Hosts the backend server

RDS (MySQL): Stores user and product data

S3: Stores user avatars and static assets

Security Group: Allows HTTP (80) and SSH (22) access for development/testing

Terraform: Used to provision all AWS resources

Terraform Outputs:

ec2_public_ip → Access the backend server

rds_endpoint → Database connection endpoint

Terraform Deployment
Ensure AWS CLI is configured with your credentials

Go to the infrastructure/ folder

Run:

bash
Code kopieren
terraform init
terraform plan
terraform apply
Use the outputs to update your .env file for database connection

Environment Variables
Important: Never commit your .env file with secrets to GitHub

Use .env.example as a template

Required variables:

text
Code kopieren
JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
Contributing
We welcome contributions!

Fork the repository

Create a new feature branch: feature/your-feature

Implement your changes and commit

Push your branch and create a Pull Request