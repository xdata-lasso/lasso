-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO country (country_id, name, population, area, languages) VALUES (1, 'default2', 1, NULL, 'default2'), (0, 'default2', NULL, 0, NULL), (2, 'default2', 0, 0, 'default1'), (3, 'default2', 1, 0, NULL), (4, 'default2', 0, 1, NULL), (5, 'default1', 1, 0, NULL), (6, 'default2', 0, NULL, 'default1');
INSERT INTO roller_coaster (roller_coaster_id, country_id, name, park, length, height, speed, opened, status) VALUES (0, 4, 'default2', NULL, NULL, 1.0, 'default2', 'default2', 'default2'), (1, 6, NULL, 'default2', NULL, NULL, 'default2', NULL, NULL), (2, 3, 'default2', 'default2', 1.0, 1.0, 'default2', NULL, NULL), (3, 1, 'default2', 'default1', 1.0, NULL, 'default2', 'default1', 'default2'), (4, 2, NULL, 'default2', 0.0, 0.0, 'default1', 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.roller_coaster_id AS roller_coaster_id, RHS.name AS name_other, RHS.park AS park, RHS.length AS LENGTH, RHS.height AS height, RHS.speed AS speed, RHS.opened AS opened, RHS.status AS status FROM country AS LHS INNER JOIN roller_coaster AS RHS ON (LHS.country_id = RHS.country_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
(None, 'default2')
(None, 'default2')
('default2', 'default2')
('default2', 'default2')
('default2', 'default2')
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID = T2.Country_ID;

/*
Prediction Result:
('default2', 'default2')
(None, 'default2')
('default2', 'default2')
('default2', 'default2')
(None, 'default2')
*/