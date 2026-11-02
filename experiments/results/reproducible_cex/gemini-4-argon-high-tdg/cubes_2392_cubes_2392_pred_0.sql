-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Huascaran', 5000.0, 1000.0, 'Andes', 'Peru');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Ojos del Salado', 4999.9, 6000.0, 'Andes', 'Chile');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Aconcagua', 6961.0, 2000.0, 'Andes', 'Argentina');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Illimani', NULL, 5500.0, 'Andes', 'Bolivia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height >= 5000.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Argentina',)
('Peru',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5000;

/*
Prediction Result:
('Argentina',)
*/