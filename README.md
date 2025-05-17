# 🎓 Online Learning Platform – PostgreSQL Backend Only

## 📘 Project Overview

This project is a **SQL-only backend** for a simulated **online learning platform**, inspired by platforms like Udemy or Coursera.  
It is designed to model the full database layer — including users, courses, lessons, enrollments, reviews, payments, and reporting — using only **PostgreSQL**.

> This is a real-world, production-style relational schema built with serious intent: to showcase SQL skills from **beginner to advanced** levels.

---

## 🧱 Tech Stack

- **Database:** PostgreSQL 15+
- **Languages:** Pure SQL (DDL, DML, Views, Functions, Triggers, CTEs, Window Functions)
- **Tooling:** dbdiagram.io / drawSQL (for ERD)

---

## 🎯 Purpose

This project exists to:

- Build a complete, **scalable** database model using only SQL
- Demonstrate mastery of **relational data modeling**, **query optimization**, and **PostgreSQL-specific features**
- Simulate a complex, realistic use case that would exist in a **production-grade SaaS application**
- Provide a **portfolio-worthy** project for developers, database engineers, or backend-focused full-stack developers

---

## 🧪 What’s Included

✔ Full relational schema  
✔ Sample realistic data  
✔ Simple and advanced SQL queries  
✔ Triggers and stored procedures  
✔ Views and materialized views  
✔ Analytical queries for reporting

---

## 🗂 Directory Structure (Coming Soon)

```bash
online-learning-database/
├── README.md
├── schema/
├── queries/
├── procedures/
├── views/
└── docs/
```

## ✅ Project Phases

### 📐 PHASE 2: ERD Design

- Designed a complete **Entity Relationship Diagram (ERD)** using [dbdiagram.io](https://dbdiagram.io/)
- Modeled all key entities: `User`, `Student`, `Instructor`, `Course`, `Lesson`, `Enrollment`, `Review`, `Assignment`, `Submission`, `Payment`, `Certificate`, `CourseCategory`, and an audit log table.
- Normalized and optimized for relational integrity and scalability.
- 📎 [View ERD Diagram](./docs/ERD.png)

---

### 🏗️ PHASE 3: Schema Creation

- Created all tables using **PostgreSQL syntax** with:
  - `PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `NOT NULL`, `CHECK` constraints
  - `ON DELETE CASCADE` behavior for referential integrity
  - Identity columns (`GENERATED ALWAYS AS IDENTITY`)
- Added **smart indexing** on high-traffic and join-heavy columns
- Prepared for future expansion (audit logging, triggers, analytics)

📁 SQL File:
- [`schema/01_create_database.sql`](./schema/01_create_database.sql)
- [`schema/02_create_tables.sql`](./schema/02_create_tables.sql)

---

### 📥 PHASE 4: Sample Data Insertion

- Loaded test data using `COPY` for local CSV import
- Ensured correct insert order to respect foreign key dependencies
- Populated key tables with realistic dummy records:
  - Users (students and instructors)
  - Courses, lessons, enrollments
  - Assignments and submissions
  - Reviews, payments, and certificates

📁 SQL File:
- [`schema/03_insert_data.sql`](./schema/03_insert_data.sql)

⚠️ Note: Ensure file paths are correct and `\COPY` statements are run from `psql` or a client that supports them.

---

## 🔍 Features Covered (So Far)

| Feature                     | SQL Concepts Used                                      |
|----------------------------|--------------------------------------------------------|
| Relational schema design   | `PRIMARY KEY`, `FOREIGN KEY`, normalization            |
| Constraints & validation   | `NOT NULL`, `CHECK`, `UNIQUE`                         |
| Auto-generated keys        | `GENERATED ALWAYS AS IDENTITY`                        |
| Indexing                   | `CREATE INDEX` on foreign keys and lookup fields       |
| Data import                | `COPY FROM CSV`                                        |
| Cascade behavior           | `ON DELETE CASCADE` for cleanup logic                  |

---

## 🔄 Next Steps

Coming up:
- PHASE 5: Complex Queries & Reporting (`JOIN`, `GROUP BY`, CTEs, `RANK()`, `AVG()`, `WINDOW FUNCTIONS`)
- PHASE 6: Stored Procedures, Triggers, and Views
- PHASE 7: Materialized Views for recommendations
- PHASE 8: Performance Optimizations & Analytics

---

## 🏁 How to Run

```bash
# Open PostgreSQL terminal or pgAdmin
-- Step 1: Create Tables
\i schema/02_create_tables.sql

-- Step 2: Insert Sample Data
\i schema/03_insert_data.sql
```
---
## 👨‍💻 Author

Built by Richa as a production-grade SQL-only backend project to demonstrate real-world PostgreSQL expertise.
> For feedback, contributions, or collaboration, feel free to reach out via GitHub or LinkedIn.
---
## 🔗 License
MIT License – free for personal and professional use.