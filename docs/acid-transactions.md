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

    BEGIN;                          -- start transaction
        INSERT INTO ...;
        SAVEPOINT my_savepoint;     -- create restore point
        UPDATE ...;
        -- ROLLBACK TO my_savepoint; -- undo back to savepoint
    COMMIT;                         -- make all changes permanent
    -- or ROLLBACK;                 -- undo everything

## Isolation Levels (Exam Topic)

| Level | Dirty Read | Non-Repeatable Read | Phantom Read |
|-------|-----------|-------------------|-------------|
| READ UNCOMMITTED | Possible | Possible | Possible |
| READ COMMITTED | Prevented | Possible | Possible |
| REPEATABLE READ | Prevented | Prevented | Possible |
| SERIALIZABLE | Prevented | Prevented | Prevented |

Set isolation level in PostgreSQL:

    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

## Exam Frequency

ACID / Transactions appear in **63% of past exams** (10/15).
