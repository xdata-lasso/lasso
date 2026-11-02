-- Schema DDL
CREATE TABLE Races (race_id INTEGER PRIMARY KEY, year INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "races" ("race_id", "year", "name") VALUES (1005, 2017, 'Angie Henderson');
INSERT INTO "races" ("race_id", "year", "name") VALUES (1006, 2017, 'Daniel Wagner');
INSERT INTO "races" ("race_id", "year", "name") VALUES (1007, 2000, 'Angie Henderson');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Races WHERE year = 2017 AND NOT name IN (SELECT name FROM Races WHERE year = 2000);

/*
Gold Result:
('Daniel Wagner',)
*/

-- Prediction Query
SELECT name FROM Races WHERE year = 2017 AND NOT race_id IN (SELECT race_id FROM Races WHERE year = 2000);

/*
Prediction Result:
('Angie Henderson',)
('Daniel Wagner',)
*/