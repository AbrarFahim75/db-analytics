# ACID Properties & Transactions

## ACID Properties

### Atomicity
A transaction is indivisible: either **all** operations succeed, or **none** do.
If any statement within a transaction fails, all changes are rolled back.

### Consistency
A transaction brings the database from one **valid state** to another.
All integrity constraints must be satisfied after the transaction completes.

### Isolation
Concurrent transactions execute as if they were running **sequentially**.
One transaction cannot see the intermediate results of another.

### Durability
Once a transaction is **committed**, its changes are permanent and survive
system crashes, power failures, or other errors.

## PostgreSQL Transaction Syntax

```sql
BEGIN;                          -- start transaction
    INSERT INTO ...;
    SAVEPOINT my_savepoint;     -- create restore point
    UPDATE ...;
    -- ROLLBACK TO my_savepoint; -- undo back to savepoint
COMMIT;                         -- make all changes permanent
-- or ROLLBACK;                 -- undo everything
```

## Isolation Levels (Exam Topic)

| Level | Dirty Read | Non-Repeatable Read | Phantom Read |
|-------|-----------|-------------------|-------------|
| READ UNCOMMITTED | Possible | Possible | Possible |
| READ COMMITTED | Prevented | Possible | Possible |
| REPEATABLE READ | Prevented | Prevented | Possible |
| SERIALIZABLE | Prevented | Prevented | Prevented |

```sql
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
```

## Exam Frequency

ACID / Transactions appear in **63% of past exams** (10/15).

---- END ----


################################################################
# COMPLETE TASK LIST WITH FILENAMES AND COMMIT MESSAGES
################################################################
#
# TASK 3:  labs/lab1/README.md          → "Add Lab 1 README with assignment overview"
# TASK 4:  labs/lab2/README.md          → "Add Lab 2 README with ER modeling assignments"
# TASK 5:  labs/lab3/README.md          → "Add Lab 3 README with normalization assignments"
# TASK 6:  labs/lab4/README.md          → "Add Lab 4 README with transactions and triggers assignments"
# TASK 7:  schemas/shipping-erd.md      → "Add shipping company ER diagram with Mermaid"
# TASK 8:  schemas/chemistry-erd.md     → "Add chemistry database ER diagram with Mermaid"
# TASK 9:  schemas/geography-erd.md     → "Add geography database ER diagram with Mermaid"
# TASK 10: sql/window-functions/README.md → "Label window functions as industry extension beyond course scope"
# TASK 11: sql/normalization/README.md  → "Add normalization directory with definitions and exam relevance"
# TASK 12: sql/normalization/invoice_normalization.sql → "Add invoice normalization example (1NF → 2NF → 3NF)"
# TASK 13: sql/triggers/README.md       → "Add triggers directory with concept overview"
# TASK 14: sql/triggers/changelog_trigger.sql → "Add changelog trigger example for Chemistry database"
# TASK 15: sql/transactions/README.md   → "Add transactions directory with ACID overview"
# TASK 16: sql/transactions/chemistry_transaction.sql → "Add chemistry transaction examples with SAVEPOINT"
# TASK 17: sql/views/README.md          → "Add views directory with updatability rules"
# TASK 18: sql/views/researcher_view.sql → "Add view examples with updatability analysis"
# TASK 19: docs/er-modeling.md          → "Add ER modeling documentation with notation comparison"
# TASK 20: docs/acid-transactions.md    → "Add ACID and transactions documentation"
# TASK 21: (Edit existing .sql files to add headers — no new file needed)
#
################################################################
