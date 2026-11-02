-- Schema DDL
CREATE TABLE seasons (year INTEGER PRIMARY KEY);

CREATE TABLE races (raceid INTEGER PRIMARY KEY, year INTEGER, round INTEGER, FOREIGN KEY (year) REFERENCES seasons (year));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO seasons (year) VALUES (0), (1), (2), (3);
INSERT INTO races (raceid, year, round) VALUES (2, 1, NULL), (0, 3, NULL), (1, 0, 2), (3, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(round) DESC, year NULLS LAST LIMIT 1;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(*) DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
(1,)
*/