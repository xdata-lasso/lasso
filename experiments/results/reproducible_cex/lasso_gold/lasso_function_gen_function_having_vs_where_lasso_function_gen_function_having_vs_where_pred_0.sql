-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollment (course_id INTEGER, grade REAL, FOREIGN KEY (course_id) REFERENCES course (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("id", "name") VALUES (1003, 'Angie Henderson');
INSERT INTO "enrollment" ("course_id", "grade") VALUES (1003, 80);
INSERT INTO "enrollment" ("course_id", "grade") VALUES (1003, 80);
INSERT INTO "enrollment" ("course_id", "grade") VALUES (1003, 92.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name HAVING AVG(e.grade) > 85;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.name, ROUND(AVG(e.grade), 2) FROM course AS c JOIN enrollment AS e ON c.id = e.course_id GROUP BY c.name;

/*
Prediction Result:
('Angie Henderson', 84.0)
*/