-- Schema DDL
CREATE TABLE teams (id INTEGER PRIMARY KEY, name TEXT(50));

CREATE TABLE users (id INTEGER PRIMARY KEY, team_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO teams (id, name) VALUES (10, 'Engineering');
INSERT INTO users (id, team_id) VALUES (1, NULL);
INSERT INTO users (id, team_id) VALUES (2, 10);
INSERT INTO users (id, team_id) VALUES (3, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM users WHERE NOT team_id IN (SELECT id FROM teams);

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT u.id FROM users AS u LEFT JOIN teams AS t ON u.team_id = t.id WHERE t.id IS NULL;

/*
Prediction Result:
(1,)
(3,)
*/