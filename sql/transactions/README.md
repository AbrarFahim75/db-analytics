# Transactions

Transactions and ACID properties appear in **63% of past exams**.

## Contents

- `chemistry_transaction.sql` — Multi-table insert with ROLLBACK on error
- `savepoint_example.sql` — Using SAVEPOINT for partial rollback

## ACID Properties

- **Atomicity:** All-or-nothing execution
- **Consistency:** Database moves from one valid state to another
- **Isolation:** Concurrent transactions do not interfere
- **Durability:** Committed changes survive system failures

## SQL Transaction Statements

- `BEGIN` — Start a transaction
- `COMMIT` — Save all changes
- `ROLLBACK` — Undo all changes since BEGIN
- `SAVEPOINT name` — Create a named restore point
- `ROLLBACK TO name` — Undo changes back to the savepoint
