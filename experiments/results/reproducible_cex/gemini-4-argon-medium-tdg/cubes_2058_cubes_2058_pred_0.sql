-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (1, 'Canada', 38000000, 9984670, 'English, French');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (2, 'Australia', 25000000, 7692024, 'English');
INSERT INTO country (Country_ID, Name, Population, Area, Languages) VALUES (3, NULL, 1000, 500, 'None');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (1, 1, 'Goliath', 'La Ronde', 1231.0, 53.0, '110 km/h', '2006', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (2, 2, 'Goliath', 'Warner Bros', 1000.0, 45.0, '100 km/h', '2010', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (3, 3, 'Goliath', 'Mystery Park', 800.0, 30.0, '80 km/h', '2000', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (4, 1, 'Behemoth', 'Canadas Wonderland', 1620.9, 70.1, '123.9 km/h', '2008', 'Operating');
INSERT INTO roller_coaster (Roller_Coaster_ID, Country_ID, Name, Park, Length, Height, Speed, Opened, Status) VALUES (5, 2, NULL, 'Null Coaster Park', 500.0, 10.0, '40 km/h', '2015', 'Operating');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.roller_coaster_id AS roller_coaster_id, RHS.name AS name_other, RHS.park AS park, RHS.length AS LENGTH, RHS.height AS height, RHS.speed AS speed, RHS.opened AS opened, RHS.status AS status FROM country AS LHS INNER JOIN roller_coaster AS RHS ON (LHS.country_id = RHS.country_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
(None, 'Australia')
('Behemoth', 'Canada')
('Goliath', 'Australia')
('Goliath', 'Canada')
('Goliath', None)
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID = T2.Country_ID;

/*
Prediction Result:
('Goliath', 'Canada')
('Goliath', 'Australia')
('Goliath', None)
('Behemoth', 'Canada')
(None, 'Australia')
*/