# GroceryMate 🛒

**GroceryMate** is a modern, full-featured e-commerce platform for seamless online grocery shopping.  
Built with Python and PostgreSQL, and deployed on AWS using EC2, Lambda, S3, RDS, and DynamoDB.

---

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Screenshots & Demo](#screenshots--demo)
4. [Prerequisites](#prerequisites)
5. [Installation](#installation)
6. [Usage](#usage)
7. [AWS Services](#aws-services)
8. [Contributing](#contributing)
9. [License](#license)

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
- Git (Version control system)

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

# Create .env file and set environment variables
touch .env  # macOS/Linux
# or
ni .env -Force  # Windows

# Add the following to .env (replace placeholders)
JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}

# Start the application
python3 run.py
Usage
Open http://localhost:5000

Register/Login to your account

Browse and search for products

Add items to your basket and proceed through checkout

AWS Services
EC2: Hosts the backend server.

S3: Stores product images and static assets.

RDS: Manages the PostgreSQL database.

Lambda: Runs serverless backend functions.

DynamoDB: Optional key-value storage for session or analytics data.

Contributing
We welcome contributions!

Fork the repository

Create a new feature branch: feature/your-feature

Implement your changes and commit

Push your branch and create a Pull Request

