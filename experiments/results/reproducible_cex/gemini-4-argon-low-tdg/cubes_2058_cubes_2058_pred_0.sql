-- Schema DDL
CREATE TABLE "roller_coaster" ("Roller_Coaster_ID" INTEGER PRIMARY KEY, "Country_ID" INTEGER, "Name" TEXT, "Park" TEXT, "Length" REAL, "Height" REAL, "Speed" TEXT, "Opened" TEXT, "Status" TEXT, FOREIGN KEY ("Country_ID") REFERENCES "country" ("Country_ID"));

CREATE TABLE "country" ("Country_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Area" INTEGER, "Languages" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs OUTER JOINs, cross join, join condition mutations (e.g., country_id = roller_coaster_id), and basic ordering.
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (1, 'USA', 330000000, 9833520, 'English');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (2, 'Japan', 125000000, 377975, 'Japanese');
INSERT INTO "country" ("Country_ID", "Name", "Population", "Area", "Languages") VALUES (3, 'Germany', 83000000, 357022, 'German');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (10, 1, 'Kingda Ka', 'Six Flags', 950.4, 139.0, '128 mph', '2005', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (2, 1, 'Steel Vengeance', 'Cedar Point', 1749.5, 62.5, '74 mph', '2018', 'Operating');
INSERT INTO "roller_coaster" ("Roller_Coaster_ID", "Country_ID", "Name", "Park", "Length", "Height", "Speed", "Opened", "Status") VALUES (30, NULL, 'Orphan Coaster', 'Ghost Park', 500.0, 30.0, '40 mph', '1999', 'Removed');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name___1, name AS name___2 FROM (SELECT LHS.country_id AS country_id, LHS.name AS name, LHS.population AS population, LHS.area AS area, LHS.languages AS languages, RHS.roller_coaster_id AS roller_coaster_id, RHS.name AS name_other, RHS.park AS park, RHS.length AS LENGTH, RHS.height AS height, RHS.speed AS speed, RHS.opened AS opened, RHS.status AS status FROM country AS LHS INNER JOIN roller_coaster AS RHS ON (LHS.country_id = RHS.country_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('Kingda Ka', 'USA')
('Steel Vengeance', 'USA')
*/

-- Prediction Query
SELECT T2.Name, T1.Name FROM country AS T1 JOIN roller_coaster AS T2 ON T1.Country_ID = T2.Country_ID;

/*
Prediction Result:
('Steel Vengeance', 'USA')
('Kingda Ka', 'USA')
*/