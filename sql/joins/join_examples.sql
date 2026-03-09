-- ============================================================
-- File:    join_examples.sql
-- Schema:  lab1_2 (Shipping), lab4_2 (Geography)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: All JOIN types demonstrated with course databases.
--              Covers INNER, LEFT, RIGHT, FULL, CROSS joins.
-- ============================================================


-- ############################################################
-- INNER JOIN — returns only matching rows from both tables
-- ############################################################

SET SEARCH_PATH TO lab1_2;

-- Find all sailors and the ships they are hired on
SELECT s.lastName, sh.name AS ship_name, h.annualSalary
FROM Sailor s
INNER JOIN Hire h ON s.sailorID = h.sailorID
INNER JOIN Ship sh ON h.shipID = sh.shipID;

-- Find all sailors and the harbour where they trained
SELECT s.lastName, ha.location AS training_harbour
FROM Sailor s
INNER JOIN Harbour ha ON s.trainedAt = ha.harbourID;


-- ############################################################
-- LEFT JOIN — all rows from left table, NULLs where no match
-- ############################################################

-- Find ALL harbours and any ships based there (including harbours with no ships)
SELECT ha.location, sh.name AS ship_name
FROM Harbour ha
LEFT JOIN Ship sh ON ha.harbourID = sh.baseHarbour;

-- Result includes Rotterdam with NULL (no ships based there)


-- Find harbours with NO ships (LEFT JOIN + IS NULL pattern)
-- This is the standard exam technique for "find entities without a relationship"
SELECT ha.location
FROM Harbour ha
LEFT JOIN Ship sh ON ha.harbourID = sh.baseHarbour
WHERE sh.shipID IS NULL;

-- Result: Rotterdam


-- ############################################################
-- RIGHT JOIN — all rows from right table, NULLs where no match
-- ############################################################

-- Find all ships and their base harbour (keep all ships even if harbour missing)
SELECT sh.name AS ship_name, ha.location AS base_harbour
FROM Harbour ha
RIGHT JOIN Ship sh ON ha.harbourID = sh.baseHarbour;


-- ############################################################
-- FULL OUTER JOIN — all rows from both tables
-- ############################################################

-- Show all sailors and all ships, whether or not they are connected
SELECT s.lastName, sh.name AS ship_name
FROM Sailor s
FULL OUTER JOIN Hire h ON s.sailorID = h.sailorID
FULL OUTER JOIN Ship sh ON h.shipID = sh.shipID;

-- Sailors with no hire and ships with no crew both appear with NULLs


-- ############################################################
-- CROSS JOIN — Cartesian product (every combination)
-- ############################################################

-- All possible sailor-ship pairings (regardless of actual hire)
SELECT s.lastName, sh.name
FROM Sailor s
CROSS JOIN Ship sh;

-- Returns 5 sailors × 3 ships = 15 rows


-- ############################################################
-- SELF JOIN — joining a table to itself
-- ############################################################

-- Find pairs of sailors who trained at the same harbour
SELECT s1.lastName AS sailor1, s2.lastName AS sailor2, ha.location
FROM Sailor s1
INNER JOIN Sailor s2 ON s1.trainedAt = s2.trainedAt AND s1.sailorID < s2.sailorID
INNER JOIN Harbour ha ON s1.trainedAt = ha.harbourID;


-- ############################################################
-- GEOGRAPHY DATABASE — multi-table joins
-- ############################################################

SET SEARCH_PATH TO lab4_2, public;

-- Join Countries → Cities → Rivers → Mountains (4-table join)
SELECT
    c.CountryName,
    ci.CityName,
    ci.Population AS city_pop,
    r.RiverName,
    r.Length AS river_km,
    m.MountainName,
    m.Height AS mountain_m
FROM Countries c
INNER JOIN Cities ci ON c.CountryID = ci.CountryID
LEFT JOIN Rivers r ON c.CountryID = r.CountryID
LEFT JOIN Mountains m ON c.CountryID = m.CountryID
ORDER BY c.CountryName;

-- Countries with their spoken languages (M:N through junction table)
SELECT c.CountryName, l.LanguageName
FROM Countries c
INNER JOIN CountryLanguages cl ON c.CountryID = cl.CountryID
INNER JOIN Languages l ON cl.LanguageID = l.LanguageID
ORDER BY c.CountryName;
