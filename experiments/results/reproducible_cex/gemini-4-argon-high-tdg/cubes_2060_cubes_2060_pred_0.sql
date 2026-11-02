-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 331000000, 9833520, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (2, 'Japan', 125800000, 377975, 'Japanese');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (3, 'Germany', 83200000, 357022, 'German');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 3, 'Zeta', 'Park C', 20.0, 300.0, '90', '2020', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 2, 'Beta', 'Park B', 20.0, 100.0, '70', '2010', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 1, 'Alpha', 'Park A', 20.0, 200.0, '80', '2015', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 1, 'Delta', 'Park D', 9.5, 400.0, '95', '2005', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (5, 2, 'Epsilon', 'Park E', 100.25, 50.0, '60', '2000', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LENGTH, height FROM roller_coaster ORDER BY LENGTH, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
(9.5, 400.0)
(20.0, 300.0)
(20.0, 100.0)
(20.0, 200.0)
(100.25, 50.0)
*/

-- Prediction Query
SELECT LENGTH, Height FROM roller_coaster;

/*
Prediction Result:
(20.0, 300.0)
(20.0, 100.0)
(20.0, 200.0)
(9.5, 400.0)
(100.25, 50.0)
*/