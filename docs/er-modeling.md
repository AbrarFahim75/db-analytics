# Entity-Relationship Modeling

## Chen Notation

- **Entity types:** Rectangles
- **Attributes:** Ovals (key attributes underlined)
- **Relationship types:** Diamonds
- **Cardinalities:** Numbers near entity types (1, n, m)
- **Weak entities:** Double rectangles
- **Identifying relationships:** Double diamonds
- **Participation:**
  - Partial: single line
  - Total: double line

## MC (Modified Chen) Notation

- **Cardinalities** written as (min, max) on each side of the relationship line
- **(0, *)** = partial participation, many
- **(1, *)** = total participation, many
- **(1, 1)** = total participation, exactly one
- **(0, 1)** = partial participation, at most one

## Key Differences (Exam-Critical)

| Feature | Chen | MC |
|---------|------|-----|
| Total participation | Double line | min ≥ 1 |
| Partial participation | Single line | min = 0 |
| "Exactly one" | 1 + double line | (1,1) |
| "Many, optional" | n + single line | (0,*) |

## Exam Frequency

ER diagram creation appears in **100% of past exams** (15/15).
The most common sub-questions ask to:
1. Draw an ERD from a text description
2. Explain chosen cardinalities
3. Compare Chen vs. MC notation
4. Identify weak entities and derived attributes
