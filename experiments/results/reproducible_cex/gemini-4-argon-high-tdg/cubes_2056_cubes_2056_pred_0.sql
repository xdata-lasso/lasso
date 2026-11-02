-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 331000000, 9833520, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Coaster Exact Low', 'Park A', 50.0, 100.0, '50 mph', '2000', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 1, 'Coaster Exact High', 'Park B', 5000.0, 3300.0, '120 mph', '2005', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 1, 'Coaster Just Below', 'Park C', 500.0, 99.9, '45 mph', '1999', 'Removed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 1, 'Coaster Just Above', 'Park D', 1500.0, 3300.1, '130 mph', '2010', 'Under Construction');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (5, 1, 'Coaster Null Height', 'Park E', 1000.0, NULL, '60 mph', '2015', 'SBNO');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT status FROM roller_coaster WHERE (height <= 3300.0 AND height >= 100.0) ORDER BY status, roller_coaster.roller_coaster_id NULLS LAST;

/*
Gold Result:
('Closed',)
('Operating',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster WHERE LENGTH > 3300 OR Height > 100;

/*
Prediction Result:
('Closed',)
('Under Construction',)
*/