# Triggers

Triggers appear in **25% of past exams** and their frequency is increasing.

## Contents

- `changelog_trigger.sql` — Automatic logging trigger (Chemistry database pattern)

## Key Concepts

- **BEFORE trigger:** Fires before the operation; can modify the NEW row
- **AFTER trigger:** Fires after the operation; cannot modify the row
- **INSTEAD OF trigger:** Replaces the operation (used on views)
- **FOR EACH ROW:** Fires once per affected row
- **FOR EACH STATEMENT:** Fires once per SQL statement
- **NEW / OLD:** References to the new and old row values
```
