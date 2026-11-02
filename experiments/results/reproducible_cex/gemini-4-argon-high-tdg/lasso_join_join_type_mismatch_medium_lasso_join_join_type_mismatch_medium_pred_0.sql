-- Schema DDL
CREATE TABLE classes (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollments (id INTEGER PRIMARY KEY, class_id INTEGER, student_id INTEGER, FOREIGN KEY (class_id) REFERENCES classes (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO classes (id, name) VALUES (10, 'Mathematics');
INSERT INTO classes (id, name) VALUES (20, 'History');
INSERT INTO classes (id, name) VALUES (30, 'Physics');
INSERT INTO classes (id, name) VALUES (40, 'Chemistry');
INSERT INTO enrollments (id, class_id, student_id) VALUES (1, 10, 101);
INSERT INTO enrollments (id, class_id, student_id) VALUES (2, 10, 102);
INSERT INTO enrollments (id, class_id, student_id) VALUES (3, 20, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c LEFT JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Gold Result:
('Chemistry', 0)
('History', 1)
('Mathematics', 2)
('Physics', 0)
*/

-- Prediction Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c INNER JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Prediction Result:
('History', 1)
('Mathematics', 2)
*/