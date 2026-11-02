-- Schema DDL
CREATE TABLE "ENROLLMENT" (
    "STUDENT_ID" INT,
    "COURSE_ID" TEXT
);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO ENROLLMENT VALUES (NULL, 493822003546640271);
INSERT INTO ENROLLMENT VALUES (0, 1074739121402681865);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT student_id FROM enrollment WHERE course_id = 'CS101' AND NOT student_id IN (SELECT student_id FROM enrollment WHERE course_id = 'MATH201');

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT student_id FROM enrollment WHERE course_id = 'CS101' AND NOT student_id IN (SELECT student_id FROM enrollment WHERE course_id IN ('MATH201', 'PHYS301'));

/*
Prediction Result:
*/