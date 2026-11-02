-- Schema DDL
CREATE TABLE classes (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollments (id INTEGER PRIMARY KEY, class_id INTEGER, student_id INTEGER, FOREIGN KEY (class_id) REFERENCES classes (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic LEFT JOIN (class with 0 enrollments vs 1 vs multiple), duplicate student_id in the same class, and accidental join condition mutations (e.g., c.id = e.id or c.id = e.student_id).
INSERT INTO classes (id, name) VALUES (1, 'Math');
INSERT INTO classes (id, name) VALUES (2, 'History');
INSERT INTO classes (id, name) VALUES (3, 'Art');
INSERT INTO enrollments (id, class_id, student_id) VALUES (10, 1, 100);
INSERT INTO enrollments (id, class_id, student_id) VALUES (11, 1, 100);
INSERT INTO enrollments (id, class_id, student_id) VALUES (12, 1, 101);
INSERT INTO enrollments (id, class_id, student_id) VALUES (13, 2, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c LEFT JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Gold Result:
('Art', 0)
('History', 1)
('Math', 3)
*/

-- Prediction Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c CROSS JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Prediction Result:
('History', 1)
('Math', 3)
*/