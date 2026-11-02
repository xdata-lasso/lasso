-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 330000000, 9833520, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (10, 1, 'Coaster A', 'Park A', 500.0, 99.9, '60 mph', '2000', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (20, 1, 'Coaster B', 'Park B', 1000.0, 100.0, '70 mph', '2005', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (5, 1, 'Coaster C', 'Park C', 1500.0, 1500.0, '80 mph', '2010', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (15, 1, 'Coaster D', 'Park D', 2000.0, 3300.0, '90 mph', '2015', 'Under Construction');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (25, 1, 'Coaster E', 'Park E', 2500.0, 3300.1, '100 mph', '2020', 'Removed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (30, 1, 'Coaster F', 'Park F', 3000.0, NULL, '110 mph', '2021', 'Unknown');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM roller_coaster WHERE (height <= 3300.0 AND height >= 100.0) ORDER BY status, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('Operating',)
('Operating',)
('Under Construction',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster WHERE LENGTH > 3300 OR Height > 100;

/*
Prediction Result:
('Operating',)
('Under Construction',)
('Removed',)
*/