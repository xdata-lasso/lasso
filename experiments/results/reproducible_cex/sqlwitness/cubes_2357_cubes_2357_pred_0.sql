-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county_public_safety (county_id, name, population, police_officers, residents_per_officer, case_burden, crime_rate, police_force, location) VALUES (99, NULL, NULL, 100, 101, 99, 101.0, 'default1', NULL), (100, 'default2', 0, NULL, 1, NULL, 101.0, NULL, 'default2'), (101, 'default1', 1, 0, 0, 1, 1.0, NULL, NULL);
INSERT INTO city (city_id, county_id, name, white, black, amerindian, asian, multiracial, hispanic) VALUES (0, 101, 'default1', 99.0, NULL, 99.0, NULL, NULL, 0.0), (101, 100, 'default1', 99.0, 99.0, 101.0, 1.0, 1.0, 1.0), (100, 100, 'default1', 100.0, 1.0, 100.0, 1.0, 100.0, 99.0), (99, 101, 'default2', 1.0, 99.0, 1.0, NULL, 99.0, 0.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name_other AS name FROM (SELECT * FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION, RHS.city_id AS city_id, RHS.county_id AS county_id_other, RHS.name AS name_other, RHS.white AS white, RHS.black AS black, RHS.amerindian AS amerindian, RHS.asian AS asian, RHS.multiracial AS multiracial, RHS.hispanic AS hispanic FROM county_public_safety AS LHS CROSS JOIN city AS RHS) WHERE (county_id = county_id_other)) WHERE (county_id = 100 OR crime_rate < 100.0) ORDER BY name;

/*
Gold Result:
('default1',)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT name FROM city WHERE county_id IN (SELECT county_id FROM county_public_safety WHERE Crime_rate < 100);

/*
Prediction Result:
('default1',)
('default2',)
*/