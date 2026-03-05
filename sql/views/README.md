# Views

Views appear in **25% of past exams**.

## Contents

- `researcher_view.sql` — Join view on Chemistry database (Lab 4 pattern)

## View Types (from Lecture 8)

- **Projection View:** `SELECT a, b, c FROM table`
- **Selection View:** `SELECT * FROM table WHERE condition`
- **Join View:** `SELECT * FROM A JOIN B ON ...`
- **Aggregation View:** `SELECT COUNT(*), MAX(x) FROM ...`

## Updatability Rules

A view is generally updatable if:
- Based on a **single** base table
- Includes the **primary key**
- Does **not** use GROUP BY, HAVING, DISTINCT, or aggregate functions
- Does **not** involve JOINs (in most DBMS implementations)

Join views and aggregation views are typically **not updatable**.
