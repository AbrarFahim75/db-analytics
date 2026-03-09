-- ============================================================
-- File:    lab1_shipping_solutions.sql
-- Schema:  lab1_2 (Shipping Company)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Complete solutions to Lab 1, Assignment 2
--              (Shipping Company SQL queries)
-- Prerequisite: Run shipping.sql first to create tables and data
-- ============================================================

SET SEARCH_PATH TO lab1_2;

-- ============================================================
-- Q1: Return the dob of sailors in descending order that were
--     hired on August 3rd, 2012.
-- ============================================================

SELECT s.dob
FROM Sailors
INNER JOIN Hire h ON s.sailorID = h.sailorID
WHERE h.startOfService = '2012-08-03'
ORDER BY s.dob DESC;

-- Expected: Jones (2012-02-08), Smith (2005-02-03), Ranger (2022-02-03)
-- sorted descending by dob


-- ============================================================
-- Q2: Return all information of sailors hired between
--     July 3, 2011, and September 3, 2012, whose last name
--     starts with 'J'.
-- ============================================================

SELECT s.*
FROM Sailors
INNER JOIN Hire h ON s.sailorID = h.sailorID
WHERE h.startOfService BETWEEN '2011-07-03' AND '2012-09-03'
  AND s.lastName LIKE 'J%';

-- Expected: Jones (sailorID=14) and James (sailorID=18)


-- ============================================================
-- Q3: Return for each ship the sum of the annual salary of
--     every sailor who is hired for that ship.
-- ============================================================

SELECT h.shipID, SUM(h.annualSalary) AS total_salary
FROM Hire h
GROUP BY h.shipID;

-- Expected:
--   shipID 45 → 134000  (45000 + 47000 + 42000)
--   shipID 46 → 40500
--   shipID 47 → 41000


-- ============================================================
-- Q4: Return the location of all harbors that are NOT base
--     harbor to any ship in the database.
-- ============================================================

-- Method 1: LEFT JOIN + IS NULL pattern
SELECT h.location
FROM Harbour h
LEFT JOIN Ships ON h.harbourID = s.baseHarbour
WHERE s.shipID IS NULL;

-- Method 2: NOT IN subquery
SELECT location
FROM Harbour
WHERE harbourID NOT IN (SELECT baseHarbour FROM Ship WHERE baseHarbour IS NOT NULL);

-- Method 3: NOT EXISTS
SELECT h.location
FROM Harbour h
WHERE NOT EXISTS (SELECT 1 FROM Ship s WHERE s.baseHarbour = h.harbourID);

-- Expected: Rotterdam (harbourID 345 has no ships based there)


-- ============================================================
-- Q5: Return the shipId, ship name, and the number of sailors
--     hired on the ship who earn a maximum of $42,000.
-- ============================================================

SELECT h.shipID, s.name, COUNT(h.sailorID) AS sailor_count
FROM Hire h
INNER JOIN Ship s ON h.shipID = s.shipID
WHERE h.annualSalary <= 42000
GROUP BY h.shipID, s.name;

-- Expected:
--   shipID 45, Ship1, 1  (only Jones earns 42000)
--   shipID 46, Ship2, 1  (James earns 40500)
--   shipID 47, Ship3, 1  (Ranger earns 41000)


-- ============================================================
-- Q6: Describe the result of this query:
-- ============================================================

SELECT DISTINCT h1.location
FROM SHIP s1, SHIP s2, HARBOR h1, HARBOR h2
WHERE s1.baseHarbor = h1.harborID
  AND s2.baseHarbor = h2.harborID
  AND s1.launchDate = s2.launchDate
  AND h1.location = h2.location
  AND h1.harborID != h2.harborID;

-- ANSWER: This query finds harbor locations where two DIFFERENT
-- harbors (same location name but different IDs) each have a ship
-- with the same launch date. In the current data, this returns
-- an empty result because no two different harbors share the
-- same location name. The query would only return results if
-- there were duplicate location names with different harborIDs.
