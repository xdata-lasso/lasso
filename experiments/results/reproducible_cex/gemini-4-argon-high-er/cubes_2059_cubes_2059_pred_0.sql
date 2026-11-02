-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 300000000, 9800000, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Coaster A', 'Park A', 1000.0, 100.0, '50 mph', '2000', 'Open');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 1, 'Coaster B', 'Park B', 1200.0, 120.0, '60 mph', '2005', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status, COUNT(*) OVER () AS count___ FROM roller_coaster ORDER BY status, count___ NULLS LAST;

/*
Gold Result:
('Closed', 2)
('Open', 2)
*/

-- Prediction Query
SELECT Status, COUNT(*) FROM roller_coaster GROUP BY Status;

/*
Prediction Result:
('Closed', 1)
('Open', 1)
*/