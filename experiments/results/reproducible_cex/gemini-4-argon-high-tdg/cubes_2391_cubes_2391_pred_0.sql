-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Dufourspitze', 4634.0, 2165.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Aconcagua', 6961.0, 6961.0, 'Andes', 'Argentina');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Mercedario', 6720.0, 3353.0, 'Andes', 'Argentina');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Pissis', 6793.0, 2145.0, 'Andes', 'Argentina');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (6, 'Mount Elbert', 4401.0, 2765.0, 'Rockies', 'USA');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (7, 'Mount Rainier', 4392.0, 4023.0, 'Cascades', 'USA');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (8, 'Mount Kita', 3193.0, 2239.0, 'Akaishi', 'Japan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM (SELECT country, RANGE, COUNT(*) AS n FROM mountain GROUP BY country, RANGE) WHERE (n <> 1) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Switzerland',)
*/

-- Prediction Query
SELECT Country FROM mountain GROUP BY Country HAVING COUNT(*) > 1;

/*
Prediction Result:
('Argentina',)
('Switzerland',)
('USA',)
*/