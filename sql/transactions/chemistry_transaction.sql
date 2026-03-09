---- START ----

-- ============================================================
-- File:    chemistry_transaction.sql
-- Schema:  lab4_1 (Chemistry Database)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Transaction to insert new elements and a
--              compound with full rollback on error.
--              Based on Lab 4, Assignment 1.
-- ============================================================

-- Transaction: Insert two new elements and one new compound
-- If any insertion fails, all changes are reversed
BEGIN;

    -- Insert first new element
    INSERT INTO Elements (ElementID, Symbol, Name, AtomicNumber, AtomicWeight)
    VALUES (11, 'K', 'Potassium', 19, 39.098);

    -- Insert second new element
    INSERT INTO Elements (ElementID, Symbol, Name, AtomicNumber, AtomicWeight)
    VALUES (12, 'Ca', 'Calcium', 20, 40.078);

    -- Insert new compound using the new elements
    INSERT INTO Compounds (CompoundID, Name, Formula)
    VALUES (11, 'Potassium Chloride', 'KCl');

    -- Log the transaction
    INSERT INTO ChangeLog (NEW_DATA, ACTION, TABLE_NAME, TIMESTAMP)
    VALUES ('{"description": "Added K, Ca, and KCl"}', 'BATCH_INSERT', 'Elements+Compounds', NOW());

COMMIT;

-- ============================================================
-- SAVEPOINT EXAMPLE (Lab 4, Assignment 2)
-- ============================================================

BEGIN;

    SAVEPOINT sp_lab;
    INSERT INTO Laboratories VALUES (6, 'ChemLab6', 'Building C, Room 101');

    SAVEPOINT sp_researcher;
    INSERT INTO Researchers VALUES (6, 'Sophia', 'Neumann', 6);

    SAVEPOINT sp_reactions;
    INSERT INTO Reactions VALUES (6, 'Synthesis of KCl', 'Combining potassium and chlorine.');
    INSERT INTO Reactions VALUES (7, 'Calcium Oxidation', 'Calcium reacts with oxygen.');

    -- If anything above failed, you could:
    -- ROLLBACK TO sp_researcher;  (undo researcher + reactions, keep lab)
    -- ROLLBACK TO sp_lab;         (undo everything except BEGIN)

COMMIT;
