-- ============================================================
-- File:    lab1_student_system.sql
-- Schema:  Student Information System
-- Course:  IE4 Databases, HAW Hamburg, SoSe 2025
-- Author:  Abrar Fahim
-- Description: Lab 1, Assignment 1 — CREATE TABLE and INSERT
--              for the Student Information System schema.
-- ============================================================

-- ============================================================
-- DDL: Create all tables with appropriate constraints
-- ============================================================

CREATE TABLE Program (
    programID   INT         PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    requiredCPs INT         NOT NULL CHECK (requiredCPs > 0)
);

CREATE TABLE Student (
    studentID   INT         PRIMARY KEY,
    firstName   VARCHAR(50) NOT NULL,
    lastName    VARCHAR(50) NOT NULL,
    dob         DATE,
    programID   INT,
    FOREIGN KEY (programID) REFERENCES Program(programID)
);

CREATE TABLE Course (
    courseID     INT         PRIMARY KEY,
    name        VARCHAR(100) NOT NULL,
    description TEXT,
    creditPoints INT        NOT NULL CHECK (creditPoints > 0),
    programID   INT,
    FOREIGN KEY (programID) REFERENCES Program(programID)
);

CREATE TABLE Attempts (
    studentID   INT         NOT NULL,
    courseID     INT         NOT NULL,
    year        INT         NOT NULL,
    term        VARCHAR(20) NOT NULL CHECK (term IN ('summer', 'winter')),
    grade       DECIMAL(3,1) CHECK (grade >= 0 AND grade <= 15),
    PRIMARY KEY (studentID, courseID, year, term),
    FOREIGN KEY (studentID) REFERENCES Student(studentID),
    FOREIGN KEY (courseID)  REFERENCES Course(courseID)
);

CREATE TABLE Prerequisite (
    advancedCourseID     INT NOT NULL,
    prerequisiteCourseID INT NOT NULL,
    PRIMARY KEY (advancedCourseID, prerequisiteCourseID),
    FOREIGN KEY (advancedCourseID)     REFERENCES Course(courseID),
    FOREIGN KEY (prerequisiteCourseID) REFERENCES Course(courseID)
);

-- ============================================================
-- DML: Insert sample data (minimum 2 rows per table)
-- ============================================================

INSERT INTO Program VALUES (1, 'Information Engineering', 210);
INSERT INTO Program VALUES (2, 'Computer Science', 180);

INSERT INTO Student VALUES (101, 'Abrar', 'Fahim', '2000-05-15', 1);
INSERT INTO Student VALUES (102, 'Maria', 'Schmidt', '2001-03-22', 1);
INSERT INTO Student VALUES (103, 'John', 'Smith', '1999-11-10', 2);

INSERT INTO Course VALUES (1001, 'Databases', 'Relational database systems', 5, 1);
INSERT INTO Course VALUES (1002, 'Programming 1', 'Introduction to programming', 5, 1);
INSERT INTO Course VALUES (1003, 'Programming 2', 'Advanced programming', 5, 1);
INSERT INTO Course VALUES (2001, 'Algorithms', 'Data structures and algorithms', 6, 2);

INSERT INTO Attempts VALUES (101, 1001, 2025, 'summer', 12.0);
INSERT INTO Attempts VALUES (101, 1002, 2024, 'winter', 10.0);
INSERT INTO Attempts VALUES (102, 1001, 2025, 'summer', 14.0);
INSERT INTO Attempts VALUES (103, 2001, 2025, 'summer', 8.0);

INSERT INTO Prerequisite VALUES (1003, 1002);  -- Programming 2 requires Programming 1
INSERT INTO Prerequisite VALUES (1001, 1002);  -- Databases requires Programming 1
