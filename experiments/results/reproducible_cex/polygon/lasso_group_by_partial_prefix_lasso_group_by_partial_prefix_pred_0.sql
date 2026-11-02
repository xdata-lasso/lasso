-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (5, '6', 8);
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (4, '6', 7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
('6', 1)
('6', 1)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
('6', 2)
*/