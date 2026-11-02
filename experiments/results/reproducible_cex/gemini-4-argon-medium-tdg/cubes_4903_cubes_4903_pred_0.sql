-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Lhotse', 8516.0, 610.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Annapurna', 8091.0, 2984.0, 'Annapurna Massif', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (10, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'Tenzing', 'Nepal', '11:30', 100.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, LHS.n AS n, RHS.name AS name_other FROM (SELECT mountain_id, name, height, prominence, RANGE, country, COUNT(*) OVER () AS n FROM mountain) AS LHS INNER JOIN (SELECT country, name, MAX(n) AS n FROM (SELECT mountain_id, name, height, prominence, RANGE, country, COUNT(*) OVER () AS n FROM mountain) GROUP BY country, name) AS RHS ON (LHS.mountain_id = RHS.n AND LHS.country = RHS.country)) ORDER BY RANGE;

/*
Gold Result:
*/

-- Prediction Query
SELECT RANGE FROM mountain GROUP BY RANGE ORDER BY COUNT(*) DESC, RANGE NULLS LAST LIMIT 1;

/*
Prediction Result:
('Himalayas',)
*/