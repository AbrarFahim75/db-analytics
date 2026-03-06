![PostgreSQL](https://img.shields.io/badge/PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-CC2927?style=flat&logo=postgresql&logoColor=white)
![Database](https://img.shields.io/badge/Database-555555?style=flat&logo=databricks&logoColor=white)
![MIT](https://img.shields.io/badge/MIT-F7DF1E?style=flat)
![HAW Hamburg](https://img.shields.io/badge/HAW-Hamburg-6BBE44?style=flat)

# DB Analytics
SQL • Database Design • Data Analytics • Query Optimization

A structured repository for learning and practicing **SQL, database management, and data analytics**.
This repository combines **academic coursework from HAW Hamburg** with **industry-oriented SQL practices**, including schema design, data manipulation, analytical queries, and performance optimization.

The goal of this project is to build a **strong foundation in relational databases and SQL**, while organizing exercises and examples in a way that reflects **real-world data engineering and analytics workflows**.

---

## Repository Structure
```
db-analytics/
│
├── datasets/
│   ├── shipping.sql              # Lab 1 shipping database
│   ├── chemistry.sql             # Lab 4 chemistry database
│   ├── geography.sql             # Lab 4 geography database
│   └── company.sql               # Elmasri COMPANY example
│
├── docs/
│   ├── er-modeling.md            # Chen vs. MC notation guide
│   ├── normalization.md          # 1NF → 2NF → 3NF → BCNF
│   ├── acid-transactions.md      # ACID properties explained
│   ├── sql-cheatsheet.md         # Quick reference
│   └── exam-topics.md            # Exam frequency analysis
│
├── schemas/
│   ├── shipping-erd.mermaid      # ER diagram (Mermaid syntax)
│   ├── chemistry-erd.mermaid
│   ├── geography-erd.mermaid
│   └── relational-models/        # Relational schema definitions
│
├── sql/
│   ├── ddl/                      # CREATE TABLE, ALTER, DROP
│   ├── dml/                      # INSERT, UPDATE, DELETE
│   ├── queries/                  # SELECT, WHERE, ORDER BY
│   ├── joins/                    # INNER, LEFT, RIGHT, FULL, CROSS
│   ├── aggregation/              # GROUP BY, HAVING, COUNT, SUM, AVG
│   ├── subqueries/               # IN, EXISTS, correlated subqueries
│   ├── views/                    # CREATE VIEW, updatable views
│   ├── triggers/                 # BEFORE, AFTER, INSTEAD OF
│   ├── transactions/             # BEGIN, COMMIT, ROLLBACK, SAVEPOINT
│   ├── normalization/            # Before/after decomposition examples
│   ├── window-functions/         # (Industry extension, beyond course)
│   └── optimization/             # Indexing, EXPLAIN ANALYSE
│
├── labs/
│   ├── lab1/                     # DDL, DML, SQL queries
│   ├── lab2/                     # ER diagrams, relational models
│   ├── lab3/                     # Normalization, relational algebra
│   └── lab4/                     # Transactions, views, triggers
│
├── projects/                     # Larger integrated projects
│
├── LICENSE
└── README.md
```

---

## Topics Covered

This repository includes practice and examples for:

* SQL Fundamentals
* Data Definition Language (DDL)
* Data Manipulation Language (DML)
* Data Retrieval and Filtering
* JOIN operations
* Aggregations and GROUP BY
* Subqueries
* Window Functions
* Query Optimization
* Database Schema Design

---

## Purpose of This Repository

This project serves multiple purposes:

**Academic Learning**

* Support coursework related to databases and SQL
* Organize exercises and notes in a structured format

**Professional Skill Development**

* Practice SQL queries used in real-world analytics
* Understand relational database design
* Learn query optimization and performance techniques

**Portfolio Development**

* Demonstrate SQL and database skills
* Maintain a structured GitHub repository for interviews and job applications

---

## Quick Start
````bash
# 1. Install PostgreSQL (v14+)
# 2. Create a database
createdb db_analytics

# 3. Load a sample dataset
psql db_analytics < datasets/shipping.sql

# 4. Start querying
psql db_analytics
```​
```

**Step 4:** Scroll down, write a commit message like `Enhance README with badges, course context, and quick start`, and click **"Commit changes"**.

---

## 2.3 Appropriate License Choice — No Action Needed

The MIT license is correct. No changes required here.

---

## 2.4 Commit History — Enhancement

Your 40 commits are good. One small professional improvement: **add GitHub Topics** to the repository so it appears in relevant searches.

**Step 1:** Go to https://github.com/AbrarFahim75/db-analytics (the main repository page).

**Step 2:** On the right sidebar, find the **"About"** section. Click the **gear icon** next to it.

**Step 3:** In the **"Topics"** field, add the following topics one by one (type each and press Enter):
````
sql
postgresql
database-design
normalization
er-model
haw-hamburg
data-analytics
query-optimization

---

## Technologies and Tools

* SQL
* Relational Databases (PostgreSQL / MySQL concepts)
* Git & GitHub for version control

---

## Author

Abrar Fahim
B.Sc. Information Engineering — HAW Hamburg
