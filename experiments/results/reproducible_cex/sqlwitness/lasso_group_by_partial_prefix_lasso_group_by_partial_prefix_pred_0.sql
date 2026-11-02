-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO people (people_id, birth_place, height) VALUES (1, 'default2', 0.0), (0, NULL, 0.0), (2, 'default2', 0.0), (3, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
(None, 1)
(None, 1)
('default2', 2)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
(None, 2)
('default2', 2)
*/