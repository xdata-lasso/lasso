-- Schema DDL
CREATE TABLE seasons (year INTEGER PRIMARY KEY);

CREATE TABLE races (raceid INTEGER PRIMARY KEY, year INTEGER, round INTEGER, FOREIGN KEY (year) REFERENCES seasons (year));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO seasons (year) VALUES (2020);
INSERT INTO seasons (year) VALUES (2021);
INSERT INTO races (raceid, year, round) VALUES (1, 2020, 1);
INSERT INTO races (raceid, year, round) VALUES (2, 2021, NULL);
INSERT INTO races (raceid, year, round) VALUES (3, 2021, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(round) DESC, year NULLS LAST LIMIT 1;

/*
Gold Result:
(2020,)
*/

-- Prediction Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(*) DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
(2021,)
*/