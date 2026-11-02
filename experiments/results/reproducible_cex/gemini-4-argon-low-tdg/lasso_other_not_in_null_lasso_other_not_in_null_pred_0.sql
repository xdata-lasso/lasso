-- Schema DDL
CREATE TABLE teams (id INTEGER PRIMARY KEY, name TEXT(50));

CREATE TABLE users (id INTEGER PRIMARY KEY, team_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO teams (id, name) VALUES (10, 'Alpha');
INSERT INTO teams (id, name) VALUES (20, 'Beta');
INSERT INTO users (id, team_id) VALUES (1, 10);
INSERT INTO users (id, team_id) VALUES (2, 30);
INSERT INTO users (id, team_id) VALUES (3, NULL);
INSERT INTO users (id, team_id) VALUES (4, 30);
INSERT INTO users (id, team_id) VALUES (5, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM users WHERE NOT team_id IN (SELECT id FROM teams);

/*
Gold Result:
(2,)
(4,)
(5,)
*/

-- Prediction Query
SELECT u.id FROM users AS u LEFT JOIN teams AS t ON u.team_id = t.id WHERE t.id IS NULL;

/*
Prediction Result:
(2,)
(3,)
(4,)
(5,)
*/