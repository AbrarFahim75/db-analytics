-- ============================================================
-- File:    aggregation_examples.sql
-- Schema:  lab1_2 (Shipping), lab4_2 (Geography)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Aggregate functions, GROUP BY, HAVING.
--              Includes the critical WHERE vs HAVING distinction.
-- ============================================================


-- ############################################################
-- BASIC AGGREGATE FUNCTIONS
-- ############################################################

SET SEARCH_PATH TO lab1_2;

-- COUNT: total number of sailors
SELECT COUNT(*) AS total_sailors FROM Sailor;

-- COUNT with condition: sailors trained in Hamburg
SELECT COUNT(*) AS hamburg_trained
FROM Sailor
WHERE trainedAt = 123;

-- SUM: total salary expenditure across all hires
SELECT SUM(annualSalary) AS total_payroll FROM Hire;

-- AVG: average salary
SELECT AVG(annualSalary) AS avg_salary FROM Hire;

-- MIN / MAX: salary range
SELECT MIN(annualSalary) AS lowest, MAX(annualSalary) AS highest FROM Hire;


-- ############################################################
-- GROUP BY — partition rows into groups
-- ############################################################

-- Total salary per ship
SELECT shipID, SUM(annualSalary) AS total_salary
FROM Hire
GROUP BY shipID;

-- Number of sailors per ship
SELECT shipID, COUNT(sailorID) AS crew_size
FROM Hire
GROUP BY shipID;

-- Number of ships per harbour
SELECT baseHarbour, COUNT(shipID) AS num_ships
FROM Ship
GROUP BY baseHarbour;

-- Average salary per ship
SELECT shipID, ROUND(AVG(annualSalary), 2) AS avg_salary
FROM Hire
GROUP BY shipID;


-- ############################################################
-- HAVING — filter groups AFTER aggregation
-- ############################################################

-- Ships with more than 1 hired sailor
SELECT shipID, COUNT(sailorID) AS crew_size
FROM Hire
GROUP BY shipID
HAVING COUNT(sailorID) > 1;

-- Result: shipID 45 (3 sailors)


-- Ships where total salary exceeds $50,000
SELECT shipID, SUM(annualSalary) AS total_salary
FROM Hire
GROUP BY shipID
HAVING SUM(annualSalary) > 50000;


-- ############################################################
-- CRITICAL EXAM CONCEPT: WHERE vs HAVING
-- ############################################################

-- WHERE filters ROWS before grouping
-- HAVING filters GROUPS after aggregation

-- WRONG: This will cause an error
-- SELECT shipID, COUNT(*) FROM Hire WHERE COUNT(*) > 1 GROUP BY shipID;
-- ERROR: aggregate functions are not allowed in WHERE

-- CORRECT: Use HAVING for aggregate conditions
SELECT shipID, COUNT(*) AS cnt
FROM Hire
GROUP BY shipID
HAVING COUNT(*) > 1;

-- Combined: WHERE filters rows first, then HAVING filters groups
-- Find ships where the total salary of sailors earning ≤ 42000 exceeds 40000
SELECT shipID, SUM(annualSalary) AS low_earner_total
FROM Hire
WHERE annualSalary <= 42000       -- filter individual rows first
GROUP BY shipID
HAVING SUM(annualSalary) > 40000; -- then filter the groups


-- ############################################################
-- GEOGRAPHY DATABASE — aggregation
-- ############################################################

SET SEARCH_PATH TO lab4_2, public;

-- Average city population per country
SELECT c.CountryName, ROUND(AVG(ci.Population)) AS avg_city_pop
FROM Countries c
INNER JOIN Cities ci ON c.CountryID = ci.CountryID
GROUP BY c.CountryName
ORDER BY avg_city_pop DESC;

-- Countries with rivers longer than the average river length
SELECT c.CountryName, COUNT(r.RiverID) AS long_rivers
FROM Countries c
INNER JOIN Rivers r ON c.CountryID = r.CountryID
WHERE r.Length > (SELECT AVG(Length) FROM Rivers)
GROUP BY c.CountryName
HAVING COUNT(r.RiverID) >= 1;

-- Total mountain height per country (sum of all mountains)
SELECT c.CountryName, SUM(m.Height) AS total_height, COUNT(m.MountainID) AS num_mountains
FROM Countries c
INNER JOIN Mountains m ON c.CountryID = m.CountryID
GROUP BY c.CountryName
ORDER BY total_height DESC;
