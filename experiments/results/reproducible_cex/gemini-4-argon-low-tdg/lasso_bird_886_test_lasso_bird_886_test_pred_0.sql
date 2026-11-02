-- Schema DDL
CREATE TABLE seasons (year INTEGER PRIMARY KEY);

CREATE TABLE races (raceid INTEGER PRIMARY KEY, year INTEGER, round INTEGER, FOREIGN KEY (year) REFERENCES seasons (year));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO seasons (year) VALUES (2010);
INSERT INTO seasons (year) VALUES (2011);
INSERT INTO races (raceid, year, round) VALUES (1, 2010, 1);
INSERT INTO races (raceid, year, round) VALUES (2, 2010, NULL);
INSERT INTO races (raceid, year, round) VALUES (3, 2010, NULL);
INSERT INTO races (raceid, year, round) VALUES (4, 2011, 1);
INSERT INTO races (raceid, year, round) VALUES (5, 2011, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(round) DESC, year NULLS LAST LIMIT 1;

/*
Gold Result:
(2011,)
*/

-- Prediction Query
SELECT year FROM races GROUP BY year ORDER BY COUNT(*) DESC, year NULLS LAST LIMIT 1;

/*
Prediction Result:
(2010,)
*/