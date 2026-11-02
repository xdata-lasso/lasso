-- Schema DDL
CREATE TABLE Races (race_id INTEGER PRIMARY KEY, year INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Races" ("race_id", "year", "name") VALUES (10, 2017, '11');
INSERT INTO "Races" ("race_id", "year", "name") VALUES (9, 2000, '11');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Races WHERE year = 2017 AND NOT name IN (SELECT name FROM Races WHERE year = 2000);

/*
Gold Result:
*/

-- Prediction Query
SELECT name FROM Races WHERE year = 2017 AND NOT race_id IN (SELECT race_id FROM Races WHERE year = 2000);

/*
Prediction Result:
('11',)
*/