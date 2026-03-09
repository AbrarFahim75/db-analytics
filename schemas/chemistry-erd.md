# Chemistry Database — ER Diagram

## Entity-Relationship Diagram (Mermaid)

```mermaid
erDiagram
    ELEMENTS {
        int ElementID PK
        varchar Symbol
        varchar Name
        int AtomicNumber
        real AtomicWeight
    }
    COMPOUNDS {
        int CompoundID PK
        varchar Name
        varchar Formula
    }
    REACTIONS {
        int ReactionID PK
        varchar Name
        text Description
    }
    LABORATORIES {
        int LabID PK
        varchar LabName
        varchar Location
    }
    RESEARCHERS {
        int ResearcherID PK
        varchar FirstName
        varchar LastName
        int LabID FK
    }
    CHANGELOG {
        serial LogID PK
        json NEW_DATA
        json OLD_DATE
        varchar ACTION
        varchar TABLE_NAME
        timestamp TIMESTAMP
    }

    LABORATORIES ||--o{ RESEARCHERS : "employs"
```

## Relational Schema

- **ELEMENTS** (<u>ElementID</u>, Symbol, Name, AtomicNumber, AtomicWeight)
- **COMPOUNDS** (<u>CompoundID</u>, Name, Formula)
- **REACTIONS** (<u>ReactionID</u>, Name, Description)
- **LABORATORIES** (<u>LabID</u>, LabName, Location)
- **RESEARCHERS** (<u>ResearcherID</u>, FirstName, LastName, *LabID* → LABORATORIES)
- **CHANGELOG** (<u>LogID</u>, NEW_DATA, OLD_DATE, ACTION, TABLE_NAME, TIMESTAMP)
