-- Schema DDL
CREATE TABLE classes (id INTEGER PRIMARY KEY, name TEXT);

CREATE TABLE enrollments (id INTEGER PRIMARY KEY, class_id INTEGER, student_id INTEGER, FOREIGN KEY (class_id) REFERENCES classes (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "classes" ("id", "name") VALUES (14, NULL);
INSERT INTO "classes" ("id", "name") VALUES (11, NULL);
INSERT INTO "enrollments" ("id", "class_id", "student_id") VALUES (13, 14, 20);
INSERT INTO "enrollments" ("id", "class_id", "student_id") VALUES (12, 14, 21);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c LEFT JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Gold Result:
(None, 2)
*/

-- Prediction Query
SELECT c.name, COUNT(e.student_id) FROM classes AS c CROSS JOIN enrollments AS e ON c.id = e.class_id GROUP BY c.name;

/*
Prediction Result:
(None, 2)
*/