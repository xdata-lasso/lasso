-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (people_id, birth_place, height) VALUES (10, 'Paris', 170.5);
INSERT INTO people (people_id, birth_place, height) VALUES (20, 'Paris', 170.5);
INSERT INTO people (people_id, birth_place, height) VALUES (30, 'Paris', 180.0);
INSERT INTO people (people_id, birth_place, height) VALUES (40, 'Rome', 170.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
('Paris', 2)
('Paris', 1)
('Rome', 1)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
('Paris', 3)
('Rome', 1)
*/