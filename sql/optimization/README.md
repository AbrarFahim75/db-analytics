
---

# 3️⃣ `sql/optimization/README.md`

```markdown
# Query Optimization

This folder contains SQL examples and notes related to **database performance optimization**.

Query optimization helps improve the **speed and efficiency** of database operations.

## Topics Covered

- Indexing
- Query execution plans
- Efficient JOIN strategies
- Reducing full table scans
- Optimizing WHERE conditions

## Example

```sql
CREATE INDEX idx_customer_city
ON customers(city);
