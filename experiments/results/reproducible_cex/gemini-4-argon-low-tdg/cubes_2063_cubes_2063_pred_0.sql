-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'USA', 330000000, 9800000, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (2, 'Canada', 38000000, 9980000, 'English, French');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (3, 'Mexico', 128000000, 1960000, 'Spanish');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (101, 1, 'Goliath', 'Six Flags', 1200.5, 50.0, '100 km/h', '2000', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (102, 1, 'Viper', 'Six Flags', 800.0, 30.0, '80 km/h', '1995', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (103, 2, 'Titan', 'Six Flags', 1500.0, 60.0, '110 km/h', '2005', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (104, 1, 'Demon', 'Cedar Point', 900.0, 40.0, '90 km/h', '1990', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (105, 2, 'Maverick', 'Cedar Point', 1300.0, 45.0, '105 km/h', '2007', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (106, 3, 'Raptor', 'Cedar Point', 1100.0, 42.0, '95 km/h', '1994', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (107, NULL, 'Ghost', 'Mystery Park', 500.0, 20.0, '50 km/h', '2010', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count___ FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.park AS park, RHS.status AS status, RHS.n_distinct AS n_distinct FROM country AS LHS CROSS JOIN (SELECT park, status, COUNT(DISTINCT country_id) AS n_distinct FROM roller_coaster GROUP BY park, status) AS RHS) WHERE (n_distinct >= 3000 OR n_distinct <> country_id) ORDER BY count___;

/*
Gold Result:
(0,)
(1,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM country WHERE NOT country_id IN (SELECT country_id FROM roller_coaster WHERE LENGTH > 3000);

/*
Prediction Result:
(3,)
*/