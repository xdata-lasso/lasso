-- Schema DDL
CREATE TABLE Races (race_id INTEGER PRIMARY KEY, year INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Races (race_id, year, name) VALUES (1, 2017, 'Baku GP');
INSERT INTO Races (race_id, year, name) VALUES (2, 2017, 'Monaco GP');
INSERT INTO Races (race_id, year, name) VALUES (3, 2000, 'Monaco GP');
INSERT INTO Races (race_id, year, name) VALUES (4, 2000, 'San Marino GP');
INSERT INTO Races (race_id, year, name) VALUES (5, 2016, 'German GP');
INSERT INTO Races (race_id, year, name) VALUES (6, 2018, 'French GP');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM Races WHERE year = 2017 AND NOT name IN (SELECT name FROM Races WHERE year = 2000);

/*
Gold Result:
('Baku GP',)
*/

-- Prediction Query
SELECT name FROM Races WHERE year = 2017 AND NOT race_id IN (SELECT race_id FROM Races WHERE year = 2000);

/*
Prediction Result:
('Baku GP',)
('Monaco GP',)
*/