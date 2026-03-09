-- ============================================================
-- File:    subquery_examples.sql
-- Schema:  lab1_2 (Shipping), lab4_2 (Geography)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Subquery types — scalar, IN, EXISTS, correlated.
--              Exam-relevant patterns with full explanations.
-- ============================================================


-- ############################################################
-- SCALAR SUBQUERY — returns a single value
-- ############################################################

SET SEARCH_PATH TO lab1_2;

-- Find the sailor(s) with the highest salary
SELECT s.lastName, h.annualSalary
FROM Sailor s
INNER JOIN Hire h ON s.sailorID = h.sailorID
WHERE h.annualSalary = (SELECT MAX(annualSalary) FROM Hire);

-- Result: Smith, 47000


-- Find sailors who earn more than the average salary
SELECT s.lastName, h.annualSalary
FROM Sailor s
INNER JOIN Hire h ON s.sailorID = h.sailorID
WHERE h.annualSalary > (SELECT AVG(annualSalary) FROM Hire);


-- ############################################################
-- IN SUBQUERY — checks membership in a result set
-- ############################################################

-- Find sailors who are hired on ships based in Hamburg
SELECT s.lastName
FROM Sailor s
WHERE s.sailorID IN (
    SELECT h.sailorID
    FROM Hire h
    INNER JOIN Ship sh ON h.shipID = sh.shipID
    WHERE sh.baseHarbour = 123  -- Hamburg's harbourID
);

-- Result: Meyer, Smith, Jones, James (all on Ship1 or Ship2)


-- Find harbours that have at least one ship
SELECT location
FROM Harbour
WHERE harbourID IN (SELECT baseHarbour FROM Ship);

-- Result: Hamburg, Amsterdam


-- ############################################################
-- NOT IN SUBQUERY — checks non-membership
-- ############################################################

-- Find harbours with no ships based there
SELECT location
FROM Harbour
WHERE harbourID NOT IN (
    SELECT baseHarbour FROM Ship WHERE baseHarbour IS NOT NULL
);

-- Result: Rotterdam
-- NOTE: Always add WHERE ... IS NOT NULL with NOT IN to avoid
-- the NULL trap. If any value in the subquery is NULL,
-- NOT IN returns no rows at all.


-- ############################################################
-- EXISTS SUBQUERY — checks if subquery returns any rows
-- ############################################################

-- Find sailors who have at least one hire record
SELECT s.lastName
FROM Sailor s
WHERE EXISTS (
    SELECT 1 FROM Hire h WHERE h.sailorID = s.sailorID
);

-- Result: all sailors except those with no hire


-- Find sailors who have NO hire record
SELECT s.lastName
FROM Sailor s
WHERE NOT EXISTS (
    SELECT 1 FROM Hire h WHERE h.sailorID = s.sailorID
);

-- Result: (empty in current data — all sailors have hires)


-- ############################################################
-- CORRELATED SUBQUERY — references the outer query
-- ############################################################

-- For each ship, find the sailor with the highest salary on that ship
SELECT s.lastName, h.shipID, h.annualSalary
FROM Sailor s
INNER JOIN Hire h ON s.sailorID = h.sailorID
WHERE h.annualSalary = (
    SELECT MAX(h2.annualSalary)
    FROM Hire h2
    WHERE h2.shipID = h.shipID  -- correlated: references outer h.shipID
);

-- Result:
--   Smith, 45, 47000  (highest on Ship1)
--   James, 46, 40500  (only one on Ship2)
--   Ranger, 47, 41000 (only one on Ship3)


-- ############################################################
-- GEOGRAPHY DATABASE — subquery examples
-- ############################################################

SET SEARCH_PATH TO lab4_2, public;

-- Find countries whose capital city has population > 5 million
SELECT CountryName
FROM Countries
WHERE CountryID IN (
    SELECT CountryID FROM Cities WHERE Population > 5000000
);

-- Find the country with the longest river
SELECT c.CountryName, r.RiverName, r.Length
FROM Countries c
INNER JOIN Rivers r ON c.CountryID = r.CountryID
WHERE r.Length = (SELECT MAX(Length) FROM Rivers);

-- Result: Egypt, Nile, 6650


-- Find countries where the mountain is taller than the average
SELECT c.CountryName, m.MountainName, m.Height
FROM Countries c
INNER JOIN Mountains m ON c.CountryID = m.CountryID
WHERE m.Height > (SELECT AVG(Height) FROM Mountains);


-- Correlated: find countries where the city population exceeds
-- 50% of the country population
SELECT c.CountryName, ci.CityName, ci.Population
FROM Countries c
INNER JOIN Cities ci ON c.CountryID = ci.CountryID
WHERE ci.Population > c.Population * 0.5;
