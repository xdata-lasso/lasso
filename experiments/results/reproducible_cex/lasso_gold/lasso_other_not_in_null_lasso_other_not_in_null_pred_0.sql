-- Schema DDL
CREATE TABLE teams (id INTEGER PRIMARY KEY, name TEXT(50));

CREATE TABLE users (id INTEGER PRIMARY KEY, team_id INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "teams" ("id", "name") VALUES (1005, 'Allison Hill');
INSERT INTO "teams" ("id", "name") VALUES (1003, 'Allison Hill');
INSERT INTO "users" ("id", "team_id") VALUES (1001, NULL);
INSERT INTO "users" ("id", "team_id") VALUES (1004, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id FROM users WHERE NOT team_id IN (SELECT id FROM teams);

/*
Gold Result:
*/

-- Prediction Query
SELECT u.id FROM users AS u LEFT JOIN teams AS t ON u.team_id = t.id WHERE t.id IS NULL;

/*
Prediction Result:
(1001,)
(1004,)
*/