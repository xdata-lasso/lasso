-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary conditions on Height (5600.0, 5600.1, 5200.0, 5199.9, 5200.1) and OR vs AND logic.
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Mount BoundaryEqual', 5600.0, 1000.0, 'RangeA', 'Country_Exclude_5600');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Mount BoundaryAbove', 5600.1, 1000.0, 'RangeA', 'Country_Include_5600_1');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Mount Exact5200', 5200.0, 1000.0, 'RangeB', 'Country_Include_5200');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Mount Below5200', 5199.9, 1000.0, 'RangeB', 'Country_Exclude_5199_9');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Mount Above5200', 5200.1, 1000.0, 'RangeB', 'Country_Exclude_5200_1');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (6, 'Mount NullHeight', NULL, 1000.0, 'RangeC', 'Country_Exclude_Null');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height > 5600.0 OR height = 5200.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Country_Include_5200',)
('Country_Include_5600_1',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5600 INTERSECT SELECT Country FROM mountain WHERE Height < 5200;

/*
Prediction Result:
*/