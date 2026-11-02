-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests GROUP BY vs COUNT(*) OVER (), duplicate status values, NULL status handling, and ORDER BY direction.
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 330000000, 9833520, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Coaster A', 'Park 1', 1000.0, 50.0, '60 mph', '2000', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 1, 'Coaster B', 'Park 1', 1200.0, 60.0, '65 mph', '2005', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 1, 'Coaster C', 'Park 2', 800.0, 40.0, '50 mph', '1995', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 1, 'Coaster D', 'Park 3', 1500.0, 70.0, '75 mph', '2010', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status, COUNT(*) OVER () AS count___ FROM roller_coaster ORDER BY status, count___ NULLS LAST;

/*
Gold Result:
(None, 4)
('Closed', 4)
('Operating', 4)
*/

-- Prediction Query
SELECT Status, COUNT(*) FROM roller_coaster GROUP BY Status;

/*
Prediction Result:
(None, 1)
('Closed', 1)
('Operating', 2)
*/