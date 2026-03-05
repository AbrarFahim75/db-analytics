-- ============================================================
-- File:    researcher_view.sql
-- Schema:  lab4_1 (Chemistry Database)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: View examples based on Lab 4, Assignment 1.
-- ============================================================

-- ============================================================
-- JOIN VIEW: Researcher details with lab information
-- This view is NOT updatable (involves a JOIN)
-- ============================================================

CREATE VIEW V_RESEARCHERS_DETAILS AS
SELECT
    r.ResearcherID,
    r.FirstName || ' ' || r.LastName AS FullName,
    l.LabName,
    l.Location
FROM Researchers r
INNER JOIN Laboratories l ON r.LabID = l.LabID;

-- Query the view
SELECT * FROM V_RESEARCHERS_DETAILS;

-- ============================================================
-- PROJECTION VIEW: Only researcher names (updatable)
-- ============================================================

CREATE VIEW V_RESEARCHER_NAMES AS
SELECT ResearcherID, FirstName, LastName
FROM Researchers;

-- This view IS updatable: single table, includes PK, no aggregation
-- INSERT INTO V_RESEARCHER_NAMES VALUES (7, 'Test', 'User');

-- ============================================================
-- AGGREGATION VIEW: Count researchers per lab (NOT updatable)
-- ============================================================

CREATE VIEW V_LAB_HEADCOUNT AS
SELECT l.LabName, COUNT(r.ResearcherID) AS researcher_count
FROM Laboratories l
LEFT JOIN Researchers r ON l.LabID = r.LabID
GROUP BY l.LabName;

-- SELECT * FROM V_LAB_HEADCOUNT;
