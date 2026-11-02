-- Schema DDL
CREATE TABLE "REGISTRATIONS" (
    "REG_ID" INT,
    "STUDENT_NAME" TEXT NOT NULL,
    "SEMESTER" TEXT,
    "COURSE_CODE" TEXT,
    PRIMARY KEY ("REG_ID"),
    CHECK (semester IN ('Fall', 'Winter', 'Spring', 'Summer'))
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO REGISTRATIONS VALUES (-1, 0, 4502896599239717123, 0);
INSERT INTO REGISTRATIONS VALUES (0, 0, 4502896599239717123, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT course_code FROM Registrations WHERE semester = 'Fall';

-- Prediction Query
SELECT course_code FROM Registrations;

-- Execution Error:
-- DATASET_ERROR: CHECK constraint failed: semester IN ('Fall', 'Winter', 'Spring', 'Summer')