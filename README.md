# DBMS--Pharmacy_Management_System

## Project Overview

This project implements a **Pharmacy Management System** database schema using MySQL. It models customers, employees, medicines, prescriptions, orders, billing, notifications, and medicine disposal with comprehensive relationships.

The database is designed to support a pharmacy's backend operations including:

- Customer and employee management
- Medicine stock tracking
- Prescription handling
- Orders and billing processing
- Notifications and drug disposal tracking

---

## Features

- **Relational database schema** with tables for Customers, Employees, Medicines, Prescriptions, Orders, Bills, Notifications, and more
- Enforcement of referential integrity via foreign keys
- Composite primary keys for multi-column uniqueness
- Sample data insertion for testing and demonstration
- Example SQL queries demonstrating typical operations and reports
- Use of `InnoDB` engine for transaction support and foreign key constraints

---

## Database Tables

| Table Name               | Description                              |
|--------------------------|------------------------------------------|
| `Customer`               | Customer details including insurance     |
| `Insurance`              | Insurance company and policy details     |
| `Employee`               | Employee records with roles and licenses |
| `Medicine`               | Medicine stock details                    |
| `Prescription`           | Prescriptions issued to customers        |
| `Prescribed_Drugs`       | Drugs prescribed under a prescription    |
| `Order_Table`            | Orders placed for prescriptions          |
| `Ordered_Drugs`          | Details of drugs in each order            |
| `Bill`                   | Billing details for customer orders      |
| `Disposed_Drugs`         | Medicines disposed from stock             |
| `Notification`           | Messages for notifications                |
| `Employee_Notification`  | Notifications linked to employees         |
| `Employee_Disposed_Drugs`| Record of disposed drugs by employees     |

---

## Getting Started

### Prerequisites

- MySQL server installed and running
- MySQL client (MySQL Workbench)
- Basic knowledge of SQL commands
