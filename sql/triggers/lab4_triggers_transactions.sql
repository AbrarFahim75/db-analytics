-- ============================================================
-- File:    lab4_triggers_transactions.sql
-- Schema:  lab4_1 (Chemistry), lab4_2 (Geography)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Complete solutions to Lab 4 — Transactions,
--              Views, and Triggers on Chemistry & Geography DBs.
-- Prerequisite: Run chemistry.sql and geography.sql first
-- ============================================================


-- ############################################################
-- PART 1: CHEMISTRY DATABASE — TRANSACTIONS
-- Lab 4, Assignment 1, Questions 1-2
-- ############################################################

SET SEARCH_PATH TO lab4_1, public;

-- Q1: Transaction to insert two new elements and a new compound.
--     If any insert fails, all changes are reversed.
--     Log the transaction in ChangeLog.

BEGIN;

    INSERT INTO Elements (ElementID, Symbol, Name, AtomicNumber, AtomicWeight)
    VALUES (11, 'K', 'Potassium', 19, 39.098);

    INSERT INTO Elements (ElementID, Symbol, Name, AtomicNumber, AtomicWeight)
    VALUES (12, 'Ca', 'Calcium', 20, 40.078);

    INSERT INTO Compounds (CompoundID, Name, Formula)
    VALUES (11, 'Potassium Chloride', 'KCl');

    -- Log all three insertions
    INSERT INTO ChangeLog (NEW_DATA, ACTION, TABLE_NAME, TIMESTAMP)
    VALUES ('{"elements": ["Potassium", "Calcium"], "compound": "KCl"}',
            'BATCH_INSERT', 'Elements+Compounds', NOW());

COMMIT;


-- Q2: Transaction with SAVEPOINTs — add new lab, researcher, and reactions

BEGIN;

    SAVEPOINT sp_lab;
    INSERT INTO Laboratories (LabID, LabName, Location)
    VALUES (6, 'ChemLab6', 'Building C, Room 101');

    INSERT INTO ChangeLog (NEW_DATA, ACTION, TABLE_NAME, TIMESTAMP)
    VALUES ('{"lab": "ChemLab6", "location": "Building C, Room 101"}',
            'INSERT', 'Laboratories', NOW());

    SAVEPOINT sp_researcher;
    INSERT INTO Researchers (ResearcherID, FirstName, LastName, LabID)
    VALUES (6, 'Sophia', 'Neumann', 6);

    INSERT INTO ChangeLog (NEW_DATA, ACTION, TABLE_NAME, TIMESTAMP)
    VALUES ('{"researcher": "Sophia Neumann", "labID": 6}',
            'INSERT', 'Researchers', NOW());

    SAVEPOINT sp_reactions;
    INSERT INTO Reactions (ReactionID, Name, Description)
    VALUES (6, 'Synthesis of KCl', 'Combining potassium and chlorine gas.');

    INSERT INTO Reactions (ReactionID, Name, Description)
    VALUES (7, 'Calcium Oxidation', 'Calcium reacts with oxygen to form calcium oxide.');

    INSERT INTO ChangeLog (NEW_DATA, ACTION, TABLE_NAME, TIMESTAMP)
    VALUES ('{"reactions": ["Synthesis of KCl", "Calcium Oxidation"]}',
            'BATCH_INSERT', 'Reactions', NOW());

COMMIT;


-- ############################################################
-- PART 2: CHEMISTRY DATABASE — VIEWS
-- Lab 4, Assignment 1, Questions 3-4
-- ############################################################

-- Q3: Create view V_RESEARCHERS_DETAILS

CREATE OR REPLACE VIEW V_RESEARCHERS_DETAILS AS
SELECT
    r.ResearcherID,
    r.FirstName || ' ' || r.LastName AS FullName,
    l.LabName,
    l.Location
FROM Researchers r
INNER JOIN Laboratories l ON r.LabID = l.LabID;

-- Verify the view
SELECT * FROM V_RESEARCHERS_DETAILS;


-- Q4: Test INSERT, DELETE, UPDATE on the view

-- INSERT: Will FAIL — this is a JOIN view (not updatable)
-- INSERT INTO V_RESEARCHERS_DETAILS VALUES (7, 'Test User', 'ChemLab1', 'Building A, Room 66');
-- ERROR: cannot insert into a view with multiple base tables

-- DELETE: Will FAIL — same reason
-- DELETE FROM V_RESEARCHERS_DETAILS WHERE ResearcherID = 1;
-- ERROR: cannot delete from a view with multiple base tables

-- UPDATE: Will FAIL — same reason
-- UPDATE V_RESEARCHERS_DETAILS SET FullName = 'New Name' WHERE ResearcherID = 1;
-- ERROR: cannot update a view with multiple base tables

-- EXPLANATION: V_RESEARCHERS_DETAILS is a JOIN view combining
-- Researchers and Laboratories. PostgreSQL cannot determine which
-- base table to modify for INSERT/DELETE/UPDATE operations.
-- Only views based on a single table without aggregation are updatable.


-- ############################################################
-- PART 3: CHEMISTRY DATABASE — TRIGGER
-- Automatic changelog logging
-- ############################################################

-- Create trigger function that logs all changes
CREATE OR REPLACE FUNCTION log_element_changes()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        INSERT INTO ChangeLog (NEW_DATA, OLD_DATE, ACTION, TABLE_NAME, TIMESTAMP)
        VALUES (row_to_json(NEW), NULL, 'INSERT', TG_TABLE_NAME, NOW());
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO ChangeLog (NEW_DATA, OLD_DATE, ACTION, TABLE_NAME, TIMESTAMP)
        VALUES (row_to_json(NEW), row_to_json(OLD), 'UPDATE', TG_TABLE_NAME, NOW());
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        INSERT INTO ChangeLog (NEW_DATA, OLD_DATE, ACTION, TABLE_NAME, TIMESTAMP)
        VALUES (NULL, row_to_json(OLD), 'DELETE', TG_TABLE_NAME, NOW());
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

-- Attach trigger to Elements table
CREATE TRIGGER trg_elements_changelog
AFTER INSERT OR UPDATE OR DELETE ON Elements
FOR EACH ROW
EXECUTE FUNCTION log_element_changes();

-- Test: insert an element and check the log
INSERT INTO Elements VALUES (13, 'S', 'Sulfur', 16, 32.065);
SELECT * FROM ChangeLog ORDER BY LogID DESC LIMIT 1;


-- ############################################################
-- PART 4: GEOGRAPHY DATABASE — COMPLEX JOINS
-- Lab 4, Assignment 2
-- ############################################################

SET SEARCH_PATH TO lab4_2, public;

-- Q1: List all countries with their capital city and the
--     population of that capital city
SELECT c.CountryName, c.CapitalCity, ci.Population AS capital_population
FROM Countries c
INNER JOIN Cities ci ON c.CountryID = ci.CountryID
    AND c.CapitalCity = ci.CityName;

-- Q2: List all countries and the number of languages spoken
SELECT c.CountryName, COUNT(cl.LanguageID) AS num_languages
FROM Countries c
LEFT JOIN CountryLanguages cl ON c.CountryID = cl.CountryID
GROUP BY c.CountryName
ORDER BY num_languages DESC;

-- Q3: Find the tallest mountain in each country
SELECT c.CountryName, m.MountainName, m.Height
FROM Countries c
INNER JOIN Mountains m ON c.CountryID = m.CountryID
WHERE m.Height = (
    SELECT MAX(m2.Height)
    FROM Mountains m2
    WHERE m2.CountryID = c.CountryID
)
ORDER BY m.Height DESC;

-- Q4: Find countries that have both a river longer than 3000km
--     and a mountain higher than 5000m
SELECT DISTINCT c.CountryName
FROM Countries c
INNER JOIN Rivers r ON c.CountryID = r.CountryID
INNER JOIN Mountains m ON c.CountryID = m.CountryID
WHERE r.Length > 3000 AND m.Height > 5000;

-- Q5: List all continents (note: no FK between Countries and Continents
--     in this schema, so we just list them)
SELECT * FROM Continents;

-- Q6: Create a view showing country details with river and mountain info
CREATE OR REPLACE VIEW V_COUNTRY_DETAILS AS
SELECT
    c.CountryName,
    c.Population AS country_population,
    c.CapitalCity,
    r.RiverName,
    r.Length AS river_length,
    m.MountainName,
    m.Height AS mountain_height
FROM Countries c
LEFT JOIN Rivers r ON c.CountryID = r.CountryID
LEFT JOIN Mountains m ON c.CountryID = m.CountryID;

SELECT * FROM V_COUNTRY_DETAILS ORDER BY CountryName;
