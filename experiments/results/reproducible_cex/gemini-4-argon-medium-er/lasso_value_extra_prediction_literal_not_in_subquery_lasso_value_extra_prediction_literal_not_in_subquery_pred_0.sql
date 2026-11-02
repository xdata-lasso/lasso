-- Schema DDL
CREATE TABLE enrollment (student_id INTEGER, course_id TEXT(20));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enrollment (student_id, course_id) VALUES (1, 'CS101');
INSERT INTO enrollment (student_id, course_id) VALUES (1, 'PHYS301');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT student_id FROM enrollment WHERE course_id = 'CS101' AND NOT student_id IN (SELECT student_id FROM enrollment WHERE course_id = 'MATH201');

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT DISTINCT student_id FROM enrollment WHERE course_id = 'CS101' AND NOT student_id IN (SELECT student_id FROM enrollment WHERE course_id IN ('MATH201', 'PHYS301'));

/*
Prediction Result:
*/