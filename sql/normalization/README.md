# Normalization

Normalization accounts for approximately **17.5% of all exam points** across
15 past examinations. This directory contains worked examples of functional
dependency analysis and step-by-step decomposition.

## Contents

- `invoice_normalization.sql` — Decomposition of Invoice Data (1NF → 2NF → 3NF)

## Key Definitions

- **1NF:** All attribute values are atomic (no repeating groups)
- **2NF:** In 1NF + no partial dependencies (every non-key attribute depends on the full PK)
- **3NF:** In 2NF + no transitive dependencies (no non-key attribute depends on another non-key)
- **BCNF:** For every non-trivial FD X → Y, X is a superkey
```

Commit message: `Add normalization directory with definitions and exam relevance`
