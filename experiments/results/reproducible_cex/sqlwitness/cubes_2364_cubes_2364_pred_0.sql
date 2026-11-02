-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county_public_safety (county_id, name, population, police_officers, residents_per_officer, case_burden, crime_rate, police_force, location) VALUES (11, NULL, 10, 11, 9, 11, 0.0, 'default1', 'default1'), (9, NULL, 9, 11, 1, 0, 11.0, 'default2', 'default1'), (10, NULL, NULL, NULL, 1, NULL, 11.0, 'default1', 'default1'), (1, 'default1', 9, NULL, 10, 1, 11.0, 'default2', NULL), (0, 'default1', NULL, 0, 9, 0, 0.0, 'default1', 'default2'), (2, 'default2', 0, 9, 0, 10, 1.0, NULL, NULL), (3, 'default1', 1, 11, NULL, 10, 9.0, NULL, NULL), (4, 'default1', 11, 1, 11, NULL, 10.0, 'default2', 'default1'), (5, 'default2', 9, 1, NULL, 1, NULL, NULL, NULL), (6, 'default1', NULL, 11, 0, 0, 0.0, 'default1', 'default1'), (7, NULL, 11, 1, NULL, 11, 0.0, 'default2', 'default2'), (8, 'default2', 1, 9, 11, 10, 1.0, 'default1', 'default2'), (12, 'default2', 11, 11, 11, 9, NULL, NULL, 'default2'), (13, NULL, 11, 9, 11, NULL, 1.0, NULL, 'default1'), (14, 'default1', 10, 9, NULL, 0, 1.0, NULL, 'default2'), (15, 'default2', 0, 9, 9, 1, 0.0, 'default1', 'default1'), (16, 'default2', 11, NULL, 9, 1, 9.0, 'default1', 'default1'), (17, 'default1', 1, 11, 1, 1, 0.0, NULL, 'default1'), (18, 'default2', 11, 11, 0, 1, 11.0, 'default2', 'default2'), (19, NULL, 9, 11, 10, 11, 0.0, NULL, NULL), (20, 'default2', 11, 9, 11, 9, 0.0, 'default1', NULL), (21, 'default1', 0, 1, 0, 0, NULL, NULL, 'default1'), (22, 'default1', 1, 1, 9, 11, 0.0, 'default2', 'default2');
INSERT INTO city (city_id, county_id, name, white, black, amerindian, asian, multiracial, hispanic) VALUES (0, 21, NULL, 9.0, NULL, NULL, NULL, NULL, 0.0), (10, 20, 'default1', NULL, 11.0, 11.0, 11.0, 1.0, 1.0), (11, 6, NULL, 0.0, 10.0, 1.0, 1.0, 11.0, 1.0), (9, 11, 'default1', 0.0, NULL, 10.0, 10.0, 9.0, 10.0), (1, 14, NULL, NULL, 9.0, 9.0, 9.0, NULL, 10.0), (2, 21, 'default2', 0.0, NULL, 1.0, 1.0, 10.0, 0.0), (3, 20, 'default1', 0.0, 10.0, 1.0, NULL, 0.0, NULL), (4, 11, 'default1', NULL, 0.0, NULL, 11.0, 9.0, 0.0), (5, 17, NULL, 1.0, 10.0, 1.0, 11.0, 0.0, 10.0), (6, 14, NULL, NULL, 10.0, 0.0, NULL, 9.0, 10.0), (7, 21, NULL, 9.0, 1.0, 1.0, 1.0, 10.0, NULL), (8, 5, 'default2', 0.0, 10.0, NULL, 9.0, 10.0, 1.0), (12, 1, NULL, 10.0, NULL, 0.0, 0.0, 9.0, 1.0), (13, 9, 'default1', 0.0, 10.0, 10.0, 11.0, 1.0, NULL), (14, 11, 'default2', 0.0, 11.0, 0.0, NULL, 10.0, 10.0), (15, NULL, 'default1', 9.0, 10.0, 0.0, NULL, 9.0, 11.0), (16, 14, 'default2', 9.0, 10.0, 1.0, 1.0, 1.0, 11.0), (17, 5, 'default1', 9.0, 11.0, 10.0, 10.0, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hispanic FROM city WHERE (black > 10.0) ORDER BY hispanic, city.city_id NULLS LAST;

/*
Gold Result:
(None,)
(1.0,)
(10.0,)
*/

-- Prediction Query
SELECT Hispanic FROM city WHERE Black > 10;

/*
Prediction Result:
(1.0,)
(10.0,)
(None,)
*/