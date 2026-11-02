-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (1003, 'brother', 1004.5);
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (1005, NULL, 1006.5);
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (1007, 'site', 1006.5);
INSERT INTO "people" ("people_id", "birth_place", "height") VALUES (1008, NULL, 1004.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
(None, 1)
(None, 1)
('brother', 1)
('site', 1)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
(None, 2)
('brother', 1)
('site', 1)
*/