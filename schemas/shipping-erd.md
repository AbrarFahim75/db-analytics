# Shipping Company — ER Diagram

## Entity-Relationship Diagram (Mermaid)
```mermaid
erDiagram
    HARBOUR {
        int harbourID PK
        varchar location
        date establishedIn
    }
    SAILOR {
        int sailorID PK
        varchar lastName
        date dob
        int trainedAt FK
    }
    SHIP {
        int shipID PK
        varchar name
        int grossWeight
        date launchDate
        int baseHarbour FK
    }
    HIRE {
        int sailorID FK
        int shipID FK
        date startOfService
        int annualSalary
    }

    HARBOUR ||--o{ SAILOR : "trained at"
    HARBOUR ||--o{ SHIP : "base harbour"
    SAILOR ||--o{ HIRE : "is hired"
    SHIP ||--o{ HIRE : "has crew"
```

## Relational Schema

- **HARBOUR** (<u>harbourID</u>, location, establishedIn)
- **SAILOR** (<u>sailorID</u>, lastName, dob, *trainedAt* → HARBOUR)
- **SHIP** (<u>shipID</u>, name, grossWeight, launchDate, *baseHarbour* → HARBOUR)
- **HIRE** (<u>*sailorID* → SAILOR, *shipID* → SHIP</u>, startOfService, annualSalary)
