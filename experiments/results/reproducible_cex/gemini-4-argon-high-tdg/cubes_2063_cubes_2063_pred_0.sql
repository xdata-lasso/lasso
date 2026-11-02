-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (10, 'USA', 331000000, 9833520, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (20, 'Japan', 125800000, 377975, 'Japanese');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (30, 'Germany', 83200000, 357022, 'German');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 10, 'Coaster A1', 'A_Park', 1200.5, 50.0, '100 km/h', '2000', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 10, 'Coaster A2', 'A_Park', 1100.0, 45.0, '95 km/h', '2001', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 20, 'Coaster A3', 'A_Park', 1300.0, 60.0, '110 km/h', '2002', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 30, 'Coaster A4', 'A_Park', 1400.0, 65.0, '115 km/h', '2003', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (5, 10, 'Coaster B1', 'B_Park', 900.0, 30.0, '80 km/h', '1999', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (6, 10, 'Coaster B2', 'B_Park', 950.0, 35.0, '85 km/h', '2004', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (7, NULL, 'Coaster B3', 'B_Park', 800.0, 25.0, '70 km/h', '2005', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (8, 10, 'Coaster C1', 'C_Park', 1000.0, 40.0, '90 km/h', '1995', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (9, 20, 'Coaster C2', 'C_Park', 1050.0, 42.0, '92 km/h', '1996', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (10, NULL, 'Coaster D1', 'D_Park', 700.0, 20.0, '60 km/h', '1990', 'Closed');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (11, NULL, 'Coaster D2', 'D_Park', 750.0, 22.0, '65 km/h', '1991', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count___ FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.park AS park, RHS.status AS status, RHS.n_distinct AS n_distinct FROM country AS LHS CROSS JOIN (SELECT park, status, COUNT(DISTINCT country_id) AS n_distinct FROM roller_coaster GROUP BY park, status) AS RHS) WHERE (n_distinct >= 3000 OR n_distinct <> country_id) ORDER BY count___;

/*
Gold Result:
(0,)
(1,)
(2,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM country WHERE NOT country_id IN (SELECT country_id FROM roller_coaster WHERE LENGTH > 3000);

/*
Prediction Result:
(3,)
*/