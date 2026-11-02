-- Schema DDL
CREATE TABLE classes (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollments (id INTEGER PRIMARY KEY, class_id INTEGER, student_id INTEGER, FOREIGN KEY (class_id) REFERENCES classes (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO classes (id, name) VALUES (1, NULL), (0, 'default2'), (2, 'default1'), (3, NULL), (4, 'default1');
INSERT INTO enrollments (id, class_id, student_id) VALUES (1, 4, NULL), (0, 2, 1), (2, NULL, 1), (3, NULL, 1), (4, 3, 1), (5, 2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c LEFT JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Gold Result:
(None, 1)
('default1', 2)
('default2', 0)
*/

-- Prediction Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c CROSS JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Prediction Result:
(None, 1)
('default1', 2)
*/