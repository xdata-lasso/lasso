-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, birth_place, height) VALUES (1, 'New York', 170.0);
INSERT INTO people (people_id, birth_place, height) VALUES (2, 'New York', 180.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
('New York', 1)
('New York', 1)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
('New York', 2)
*/