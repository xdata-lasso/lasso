-- Schema DDL
CREATE TABLE course (id INTEGER PRIMARY KEY, name TEXT, start_date DATE, enrollment INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "course" ("id", "name", "start_date", "enrollment") VALUES (1004, 'Noah Rhodes', '2023-01-01', 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM course WHERE start_date > '2023-01-01' AND enrollment > 30;

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM course WHERE start_date > '01-01-2023' AND enrollment > 30;

/*
Prediction Result:
('Noah Rhodes',)
*/