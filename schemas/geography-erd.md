# Geography Database — ER Diagram

## Entity-Relationship Diagram (Mermaid)

```mermaid
erDiagram
    COUNTRIES {
        int CountryID PK
        varchar CountryName
        int Population
        varchar CapitalCity
    }
    CONTINENTS {
        int ContinentID PK
        varchar ContinentName
    }
    CITIES {
        int CityID PK
        varchar CityName
        int CountryID FK
        int Population
    }
    RIVERS {
        int RiverID PK
        varchar RiverName
        int Length
        int CountryID FK
    }
    MOUNTAINS {
        int MountainID PK
        varchar MountainName
        int Height
        int CountryID FK
    }
    LANGUAGES {
        int LanguageID PK
        varchar LanguageName
    }
    COUNTRYLANGUAGES {
        int CountryID FK
        int LanguageID FK
    }

    COUNTRIES ||--o{ CITIES : "has"
    COUNTRIES ||--o{ RIVERS : "has"
    COUNTRIES ||--o{ MOUNTAINS : "has"
    COUNTRIES ||--o{ COUNTRYLANGUAGES : "speaks"
    LANGUAGES ||--o{ COUNTRYLANGUAGES : "spoken in"
```

## Relational Schema

- **COUNTRIES** (<u>CountryID</u>, CountryName, Population, CapitalCity)
- **CONTINENTS** (<u>ContinentID</u>, ContinentName)
- **CITIES** (<u>CityID</u>, CityName, *CountryID* → COUNTRIES, Population)
- **RIVERS** (<u>RiverID</u>, RiverName, Length, *CountryID* → COUNTRIES)
- **MOUNTAINS** (<u>MountainID</u>, MountainName, Height, *CountryID* → COUNTRIES)
- **LANGUAGES** (<u>LanguageID</u>, LanguageName)
- **COUNTRYLANGUAGES** (<u>*CountryID* → COUNTRIES, *LanguageID* → LANGUAGES</u>)
