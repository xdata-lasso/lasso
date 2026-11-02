-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, NULL, 'Null Country & Length 1', 'Park 1', NULL, 25.0, '60 km/h', '1990', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, NULL, 'Null Country & Length 2', 'Park 2', NULL, 55.0, '75 km/h', '1992', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, NULL, 'Null Height', 'Park 3', 500.0, NULL, '50 km/h', '1995', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, NULL, 'Zero Values', 'Park 4', 0.0, 0.0, '0 km/h', '2020', 'Under Construction');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LENGTH, height FROM roller_coaster ORDER BY LENGTH, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
(None, 55.0)
(None, 25.0)
(0.0, 0.0)
(500.0, None)
*/

-- Prediction Query
SELECT LENGTH, Height FROM roller_coaster;

/*
Prediction Result:
(None, 55.0)
(None, 25.0)
(500.0, None)
(0.0, 0.0)
*/