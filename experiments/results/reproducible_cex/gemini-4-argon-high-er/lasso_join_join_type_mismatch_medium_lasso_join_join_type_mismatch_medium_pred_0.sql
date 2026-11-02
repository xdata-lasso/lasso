-- Schema DDL
CREATE TABLE classes (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollments (id INTEGER PRIMARY KEY, class_id INTEGER, student_id INTEGER, FOREIGN KEY (class_id) REFERENCES classes (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO classes (id, name) VALUES (1, 'Math');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c LEFT JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Gold Result:
('Math', 0)
*/

-- Prediction Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c INNER JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Prediction Result:
*/