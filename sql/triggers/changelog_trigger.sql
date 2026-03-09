---- START ----

-- ============================================================
-- File:    changelog_trigger.sql
-- Schema:  lab4_1 (Chemistry Database)
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Trigger that logs all changes to the Elements
--              table into the ChangeLog table. Based on Lab 4.
-- ============================================================

-- The trigger function: logs INSERT, UPDATE, DELETE operations
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

-- Attach the trigger to the Elements table
CREATE TRIGGER trg_elements_changelog
AFTER INSERT OR UPDATE OR DELETE ON Elements
FOR EACH ROW
EXECUTE FUNCTION log_element_changes();

-- ============================================================
-- TEST: Insert a new element and check the log
-- ============================================================
-- INSERT INTO Elements VALUES (11, 'K', 'Potassium', 19, 39.098);
-- SELECT * FROM ChangeLog ORDER BY LogID DESC LIMIT 1;
