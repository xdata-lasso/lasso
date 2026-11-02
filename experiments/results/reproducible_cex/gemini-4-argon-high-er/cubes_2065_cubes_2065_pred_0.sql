-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 300000000, 9800000, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Coaster1', 'Park1', 1000.0, 100.0, '50 mph', '2000', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT height, status, COUNT(*) AS n FROM roller_coaster GROUP BY height, status) WHERE (n <= 2) ORDER BY status;

/*
Gold Result:
('Operating',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status HAVING COUNT(*) > 2;

/*
Prediction Result:
*/