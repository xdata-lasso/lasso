-- Schema DDL
CREATE TABLE enrollment (student_id INTEGER, course_id TEXT(20));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO enrollment (student_id, course_id) VALUES (0, 'CS101'), (0, NULL), (NULL, NULL), (1, 'MATH201'), (NULL, NULL), (0, 'PHYS301'), (NULL, 'PHYS301'), (0, 'PHYS301'), (NULL, 'CS101'), (1, 'default1'), (NULL, NULL), (1, 'CS101'), (0, NULL), (1, NULL), (0, 'CS101'), (NULL, 'default1'), (0, 'default2'), (1, 'MATH201'), (0, 'default1'), (NULL, 'default2'), (NULL, 'CS101'), (1, 'PHYS301'), (NULL, NULL), (NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT student_id FROM enrollment WHERE course_id = 'CS101' AND NOT student_id IN (SELECT student_id FROM enrollment WHERE course_id = 'MATH201');

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT student_id FROM enrollment WHERE course_id = 'CS101' AND NOT student_id IN (SELECT student_id FROM enrollment WHERE course_id IN ('MATH201', 'PHYS301'));

/*
Prediction Result:
*/