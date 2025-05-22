# 🎓 Online Learning Platform — Database-Only Backend (PostgreSQL)  

A complete SQL database project I built to advance my PostgreSQL skills and showcase advanced database design capabilities.
---


## 📌 Project Overview
I developed this complete database backend for an online learning platform (similar to Udemy/Coursera) as part of my journey to master advanced SQL concepts. Using only PostgreSQL without any application framework, I've implemented:

- **Database design** principles with proper normalization and relationships
- **Advanced SQL techniques** including stored procedures, triggers, and window functions
- **Security implementation** with role-based access control and row-level security
- **Performance optimization** through indexing and materialized views 

This project shows my dedication to studying database fundamentals and acts as a learning resource for other SQL enthusiasts.
---


## 💡 What I Built
Through this project, I've created a learning platform database that includes:
- **Users**: Students, instructors, and administrators
- **Courses**: Organized into categories with assignments and lessons
- **Enrollments**: Tracking student registrations and progress
- **Progress**: Recording lesson completion and achievements
- **Payments**: Managing transactions
- **Reviews**: Student feedback and ratings
- **Certificates**: Automated certificate generation upon submission of all assignments of course
---

## 💻 What I Learned From This Project
This project pushed me to master several advanced SQL concepts:
- Design a complete relational database schema with appropriate constraints
- Write queries ranging from simple lookups to complex analytics
- Implement business logic with triggers and stored procedures
- Create views for simplified data access
- Set up proper database security practices
- Use transactions for data integrity
- Apply window functions for advanced analysis
---


## 📁 Project Structure
```bash
learning-platform-db/
│
├── csv_files/                    # Sample CSVs for realistic data
│
├── docs/
│   └── ERD.png                   # ER Diagram of the complete schema
│
├── schema/
│   ├── 01_create_database.sql    # Database creation
│   ├── 02_create_tables.sql      # Complete schema creation
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
│       ├── trigger_issue_certificate.sql # Triggers & function logic
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
│   └── views.sql                       # Regular and materialized views
│
└── .gitignore

```

## 🖼️ Entity Relationship Diagram
![ERD](docs/ERD.png)
*ERD for project schema*

## 🚀 Getting Started
### Prerequisites
- PostgreSQL 13+ installed
- Basic SQL knowledge to understand the concepts

### Setup Instructions
1. Clone the repository
  ```bash
  git clone https://github.com/thedevricha/learning-platform-db.git
  cd learning-platform-db
  ```
2. Unzip csv_files.zip
3. Run database setup scripts
Run SQL files in the following order using psql or your preferred tool:
```sql
psql -f schema/01_create_database.sql
psql -d learning_platform -f schema/02_create_tables.sql
psql -d learning_platform -f schema/03_insert_data.sql
```
3. Explore the queries in order of complexity:
- Start with `queries/01_beginner_queries.sql`
- Move to `queries/02_intermediate_queries.sql`
- Explore the advanced queries in the `queries/advanced/` directory
---

## 📊 SQL Skills Showcased
### Database Design
- Tables are properly normalized and have suitable relationships.
- Applied restrictions and indexes for data integrity
- Proper management of complex relationships (many-to-many)

### Advanced SQL Techniques
- **Stored Procedures**: Maintaining business logic for enrollment and payments
- **Triggers**: Automating certificate generation after submitting all assignments.
- **Common Table Expressions**: For Hierarchical Data and Complex Reports
- **Window  Functions**: For Analytical Comparison and Ranking
- **Row-Level Security**: Restricting data access according to user roles
- **Transactions**: Ensure data consistency for critical operations.

### Query Examples
From **Beginner:**
```sql
-- List all students with their user information. 
-- Return student ID, name, email, and date of birth.
SELECT s.user_id AS student_id, u.name, u.email, s.date_of_birth
FROM student s
JOIN users u ON s.user_id = u.id
```
To **Advanced**:
```sql
-- Show the average payment made by each student, and list only those who paid more than the average of all students.
WITH student_total_payment AS (
    SELECT 
      student_id,
      SUM(amount) AS total_payment
    FROM payment
    GROUP BY student_id
),
overall_avg_payment AS (
    SELECT 
      ROUND(AVG(total_payment),2) AS avg_payment
    FROM student_total_payment
)
SELECT 
    stp.student_id,
    u.name,
    stp.total_payment,
    oap.avg_payment
FROM student_total_payment stp
JOIN overall_avg_payment oap ON true
JOIN student s ON stp.student_id = s.id
JOIN users u ON s.user_id = u.id
WHERE stp.total_payment > oap.avg_payment
ORDER BY stp.total_payment DESC;
```
---

## 🎯 Why I Built This
### Personal Growth Goals
- **Expand my SQL expertise** beyond simple CRUD operations.
- **Learn database design** fundamentals for real-world applications.
- **Understand the enterprise security** patterns and implementations.
- **Develop portfolio-worthy projects** that showcase my technological expertise.

### Professional Development
This project showcases my ability to:
- Create and build complicated database systems.
- Write efficient and maintainable SQL code.
- Think about business logic and data relationships.
- Document and arrange technical work professionally.
---

## 📈 My Development Process
I did this project in a systematic manner to improve my learning.
1. **Research Phase**: Studied real-world learning platforms to find data requirements.
2. **Design Phase**: Developed ERD and planned table structures with appropriate normalization.
3. **Implementation Phase**: Developed the schema gradually testing each component.
4. **Query Development**: Started with basic queries and gradually explored complex concepts.
5. **Security Implementation**: Included role-based access control and row-level security.
6. **Optimization**: Improved performance by indexing and materialized views.
---


## 🤝 Contributing
While this is primarily my personal learning project, I welcome contributions from other SQL enthusiasts:
- Found a bug? Please open an issue
- Have a better query approach? Submit a pull request
- Want to add new features? Let's discuss it!
- Suggestions for improvements? I'm all ears!


---
## 🔗 License
This project is open-source and available for learning purposes. Free to use with attribution.