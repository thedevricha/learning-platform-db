# 🎓 Online Learning Platform — Database-Only Backend (PostgreSQL)
A robust PostgreSQL-based backend for an online learning platform — think of a mini Udemy/Coursera clone, built entirely using SQL only.
> 📘 This project is built for serious SQL learners who want hands-on practice in real-world database design, query writing, performance optimization, and access control.


## 📌 Project Overview

This project focuses purely on the database layer of an online education platform. It simulates how users (students, instructors, admins) interact with courses, enrollments, payments, and certifications — entirely driven by SQL.

Whether you're aiming to master PostgreSQL, prepare for a technical interview, or showcase your portfolio-ready project on GitHub/LinkedIn — this is built for you.

---

## 🗂 Repository Structure

```bash
learning-platform-db/
│
├── csv_files/                    # Sample CSVs for realistic data
│
├── docs/
│   └── ERD.png                   # ER Diagram of the full schema
│
├── schema/
│   ├── 01_create_database.sql    # Database creation
│   ├── 02_create_tables.sql      # Full schema creation
│   └── 03_insert_data.sql        # Sample data insertion
│
├── procedures/
│   └── enroll_student_with_payment.sql  # Stored procedure for enrollment
│
├── queries/
│   ├── 01_beginner_queries.sql         # 10 beginner-level tasks
│   ├── 02_intermediate_queries.sql     # 10 intermediate tasks
│   └── advanced/
│       ├── cte_queries.sql             # CTE-based practicals
│       ├── transaction_queries.sql     # Transaction management
│       ├── trigger_issue_certificate.sql # Triggers & certification logic
│       └── windows_function.sql        # Window functions in action
│
├── security/
│   ├── init_roles.sql                  # Role-based access control
│   ├── row_level_security.sql          # RLS implementation
│   ├── test_admin_access.sql
│   ├── test_instructor_access.sql
│   └── test_student_access.sql
│
├── views/
│   ├── materialized_views.sql
│   └── views.sql                       # Read-optimized views
│
└── .gitignore

```
## 🧠 Key Features & Concepts Covered
- ✅ Normalized relational schema design
- ✅ Hands-on with stored procedures, triggers, transactions
- ✅ Role-based & row-level security (RLS) access management
- ✅ Use of views and materialized views for performance
- ✅ Practical SQL query challenges from beginner to advanced
- ✅ Realistic sample data using CSVs

## 🖼️ Entity Relationship Diagram
![ERD](docs\ERD.png)
*ERD for project schema*

## 🚀 Getting Started
1. Clone the repository
  ```bash
  git clone https://github.com/thedevricha/learning-platform-db.git
  cd learning-platform-db
  ```
2. Create the database and schema
Run SQL files in the following order using psql or your preferred tool:
```sql
\i schema/01_create_database.sql
\i schema/02_create_tables.sql
\i schema/03_insert_data.sql
```
3. Explore queries and procedures
Start with `queries/01_beginner_queries.sql` and move up.
---

## 📌 How to Showcase

This project is **LinkedIn/GitHub-ready**. Here's how you can highlight it:

> 🧑‍💼 “Built a complete SQL-only backend for an online learning platform. Implemented role-based access control, complex business logic using triggers and stored procedures, and optimized read performance using materialized views and window functions.”

---
## 👨‍💻 Author
Built by Richa as a production-grade SQL-only backend project to demonstrate real-world PostgreSQL expertise.
> For feedback, contributions, or collaboration, feel free to reach out via GitHub or LinkedIn.
---
## 🔗 License
This project is open-source and available for learning purposes. Free to use with attribution.