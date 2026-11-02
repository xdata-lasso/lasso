-- Schema DDL
CREATE TABLE people (people_id INTEGER PRIMARY KEY, birth_place TEXT, height REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO people (people_id, birth_place, height) VALUES (1, 'New York', 180.5);
INSERT INTO people (people_id, birth_place, height) VALUES (2, 'New York', 180.5);
INSERT INTO people (people_id, birth_place, height) VALUES (3, 'New York', 175.0);
INSERT INTO people (people_id, birth_place, height) VALUES (4, 'Boston', 180.5);
INSERT INTO people (people_id, birth_place, height) VALUES (5, 'Chicago', 165.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place, height;

/*
Gold Result:
('Boston', 1)
('Chicago', 1)
('New York', 1)
('New York', 2)
*/

-- Prediction Query
SELECT birth_place, COUNT(*) FROM people GROUP BY birth_place;

/*
Prediction Result:
('Boston', 1)
('Chicago', 1)
('New York', 3)
*/