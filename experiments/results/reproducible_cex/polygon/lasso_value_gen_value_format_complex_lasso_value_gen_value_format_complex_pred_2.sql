-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (6, '01-01-20237', '2023-01-02', 797);
INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (5, '01-01-20237', '9999-12-31', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
('01-01-20237',)
('01-01-20237',)
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01-01-2023' AND enrollment > 30;

/*
Prediction Result:
('01-01-20237',)
('01-01-20237',)
*/