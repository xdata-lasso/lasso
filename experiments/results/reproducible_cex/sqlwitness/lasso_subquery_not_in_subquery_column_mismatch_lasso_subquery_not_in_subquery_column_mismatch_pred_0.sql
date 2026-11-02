-- Schema DDL
CREATE TABLE Races (race_id INTEGER PRIMARY KEY, year INTEGER, name TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO races (race_id, year, name) VALUES (2000, 2018, 'default1'), (1999, 2018, NULL), (1, 0, 'default1'), (2016, NULL, 'default1'), (2018, 2001, NULL), (2001, 0, 'default1'), (2017, 2017, 'default2'), (0, 2000, 'default2'), (2, 2018, 'default1');
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
('default2',)
*/