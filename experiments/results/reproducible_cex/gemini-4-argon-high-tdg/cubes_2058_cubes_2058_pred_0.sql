-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (10, 'Japan', 125800000, 377975, 'Japanese');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (20, 'Germany', 83240000, 357022, 'German');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (30, 'Brazil', 212600000, 8515767, 'Portuguese');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (10, 20, 'Silver Star', 'Europa-Park', 1620.0, 73.0, '127 km/h', '2002', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (20, 10, 'Steel Dragon 2000', 'Nagashima Spa Land', 2479.0, 97.0, '153 km/h', '2000', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (30, 10, 'Eejanaika', 'Fuji-Q Highland', 1153.0, 76.0, '126 km/h', '2006', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (40, NULL, 'Orphan Coaster', 'Unknown Park', 500.0, 20.0, '60 km/h', '1999', 'Closed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.roller_coaster_id AS roller_coaster_id, RHS.name AS name_other, RHS.park AS park, RHS.length AS LENGTH, RHS.height AS height, RHS.speed AS speed, RHS.opened AS opened, RHS.status AS status FROM country AS LHS INNER JOIN roller_coaster AS RHS ON (LHS.country_id = RHS.country_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Eejanaika', 'Japan')
('Silver Star', 'Germany')
('Steel Dragon 2000', 'Japan')
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID = T2.Country_ID;

/*
Prediction Result:
('Silver Star', 'Germany')
('Steel Dragon 2000', 'Japan')
('Eejanaika', 'Japan')
*/