-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Everest', 6000.0, 1000.0, 'Himalayas', 'Nepal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height > 5600.0 OR height = 5200.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Nepal',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5600 INTERSECT SELECT Country FROM mountain WHERE Height < 5200;

/*
Prediction Result:
*/