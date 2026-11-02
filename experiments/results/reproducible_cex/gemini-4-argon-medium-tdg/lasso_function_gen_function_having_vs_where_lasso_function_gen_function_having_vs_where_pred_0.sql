-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollment (course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO course (id, name) VALUES (1, 'Algorithms');
INSERT INTO course (id, name) VALUES (2, 'Databases');
INSERT INTO course (id, name) VALUES (3, 'Networks');
INSERT INTO course (id, name) VALUES (4, 'Operating Systems');
INSERT INTO enrollment (course_id, grade) VALUES (1, 80.0);
INSERT INTO enrollment (course_id, grade) VALUES (1, 90.0);
INSERT INTO enrollment (course_id, grade) VALUES (2, 85.1);
INSERT INTO enrollment (course_id, grade) VALUES (2, 85.2);
INSERT INTO enrollment (course_id, grade) VALUES (2, 85.1);
INSERT INTO enrollment (course_id, grade) VALUES (3, 70.0);
INSERT INTO enrollment (course_id, grade) VALUES (3, 75.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;

/*
Gold Result:
('Databases', 85.13)
*/

-- Prediction Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name;

/*
Prediction Result:
('Algorithms', 85.0)
('Databases', 85.13)
('Networks', 72.5)
*/