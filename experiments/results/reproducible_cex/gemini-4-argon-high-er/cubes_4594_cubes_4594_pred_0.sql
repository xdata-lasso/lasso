-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 1000, 1000, 'English');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'RC1', 'P1', 100.0, 50.0, '50', '2000', 'Open');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 1, 'RC2', 'P1', 100.0, 50.0, '50', '2000', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT status FROM (SELECT country_id, status, MAX(n) AS maxn FROM (SELECT roller_coaster_id, name, park, country_id, LENGTH, height, speed, opened, status, COUNT(*) OVER () AS n FROM roller_coaster) GROUP BY country_id, status) ORDER BY status;

/*
Gold Result:
('Closed',)
('Open',)
*/

-- Prediction Query
SELECT Status FROM roller_coaster GROUP BY Status ORDER BY COUNT(*) DESC, Status NULLS LAST LIMIT 1;

/*
Prediction Result:
('Closed',)
*/