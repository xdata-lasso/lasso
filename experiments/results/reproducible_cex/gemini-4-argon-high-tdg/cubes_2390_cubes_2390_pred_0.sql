-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Zugspitze', 5000.0, 999.9, 'Alps', 'Germany');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Matterhorn', 5000.0, 1000.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Denali', 4999.9, 1500.0, 'Alaska Range', 'USA');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Everest', 8848.0, 1000.1, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Annapurna', 8091.0, 2984.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (6, 'Ben Nevis', 1345.0, 1000.0, 'Grampian', 'UK');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM mountain WHERE (height >= 5000.0 AND prominence <> 1000.0) ORDER BY name, mountain.mountain_id NULLS LAST;

/*
Gold Result:
('Annapurna',)
('Everest',)
('Zugspitze',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE Height > 5000 OR Prominence > 1000;

/*
Prediction Result:
('Denali',)
('Everest',)
('Annapurna',)
*/