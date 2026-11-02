-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Mount_Alpha', 5895.0, 5895.0, 'Kilimanjaro_Range', 'Tanzania');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Mount_Beta', 5600.0, 5700.0, 'Andes_Range', 'Chile');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Mount_Gamma', 5600.1, 1200.0, 'Caucasus_Range', 'Georgia');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Mount_Delta', 5400.0, 5200.0, 'Alps_Range', 'France');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Mount_Epsilon', 5200.0, 800.0, 'Rockies_Range', 'Canada');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (6, 'Mount_Zeta', 5199.9, 6000.0, 'Ural_Range', 'Russia');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (7, 'Mount_Eta', 5200.1, 900.0, 'Atlas_Range', 'Morocco');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'John_Doe', 'USA', '12:30', 5200.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 2, 'Jane_Smith', 'UK', '15:00', 5800.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT country FROM mountain WHERE (height > 5600.0 OR height = 5200.0) ORDER BY country, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Canada',)
('Georgia',)
('Tanzania',)
*/

-- Prediction Query
SELECT Country FROM mountain WHERE Height > 5600 INTERSECT SELECT Country FROM mountain WHERE Height < 5200;

/*
Prediction Result:
*/