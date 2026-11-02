-- Schema DDL
CREATE TABLE Races (race_id INTEGER PRIMARY KEY, year INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Races (race_id, year, name) VALUES (1, 2017, 'Monaco GP');
INSERT INTO Races (race_id, year, name) VALUES (2, 2000, 'Monaco GP');
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
('Monaco GP',)
*/