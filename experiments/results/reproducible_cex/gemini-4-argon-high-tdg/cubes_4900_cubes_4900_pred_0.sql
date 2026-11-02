-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Zugspitze', 5000.0, 1000.0, 'Alps', 'Germany');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Mont Blanc', 4800.0, 4695.0, 'Alps', 'France');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Matterhorn', 5000.0, 2000.0, 'Pennine', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Eiger', 3967.0, 1800.0, 'Bernese', 'Switzerland');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'Hans', 'Germany', '05:00', 50.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 1, 'Greta', 'Austria', '05:30', 45.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (3, 3, 'Luca', 'Italy', '06:00', 70.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT LHS.mountain_id AS mountain_id, LHS.name AS name, LHS.height AS height, LHS.prominence AS prominence, LHS.range AS RANGE, LHS.country AS country, RHS.mountain_id AS mountain_id_other, RHS.prominence AS prominence_other, RHS.range AS range_other, RHS.country AS country_other FROM (SELECT mountain_id, name, MAX(height) OVER () AS height, prominence, RANGE, country FROM mountain) AS LHS INNER JOIN mountain AS RHS ON (LHS.height = RHS.height AND LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('Matterhorn',)
('Zugspitze',)
*/

-- Prediction Query
SELECT Name FROM mountain ORDER BY Height DESC, mountain.mountain_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zugspitze',)
*/