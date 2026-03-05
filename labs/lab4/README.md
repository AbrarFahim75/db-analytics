# Lab 4 — Transactions, Views & Triggers

**Course:** Databases IE4, HAW Hamburg, SoSe 2025  
**Datasets:** chemistry.sql, geography.sql

## Assignments

1. **Chemistry Database** — Transactions with ROLLBACK, views (V_RESEARCHERS_DETAILS), view updatability
2. **Geography Database** — Complex JOINs across Countries/Cities/Rivers/Mountains/Languages
3. **COMPANY example** — Advanced SQL queries from Elmasri
4. **Transactions** — ACID properties, SAVEPOINT, error handling

## Key Concepts Practiced

- BEGIN, COMMIT, ROLLBACK, SAVEPOINT
- CREATE VIEW and view updatability rules
- INSERT/UPDATE/DELETE on views
- Trigger functions with ChangeLog logging
- Multi-table JOINs with aggregation
```

Commit message: `Add Lab 4 README with transactions and triggers assignments`

### Step 5: Move your course SQL scripts to `datasets/`

If `shipping.sql`, `chemistry.sql`, and `geography.sql` are not already in your `datasets/` folder, add them. Go to https://github.com/AbrarFahim75/db-analytics, click **"Add file"** → **"Upload files"**, navigate to where you have the SQL scripts on your computer, drag them in, and commit with message `Add course SQL datasets (shipping, chemistry, geography)`.

---

## Fix 3.2 — Add ER Diagrams

### Step 1: Create `schemas/shipping-erd.md`

Click **"Add file"** → **"Create new file"**. Filename:
```
schemas/shipping-erd.md
