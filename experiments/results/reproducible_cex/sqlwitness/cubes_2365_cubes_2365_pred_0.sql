-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county_public_safety (county_id, name, population, police_officers, residents_per_officer, case_burden, crime_rate, police_force, location) VALUES (0, 'default2', 1, 1, NULL, 0, NULL, NULL, NULL), (1, 'default1', NULL, NULL, 1, 1, 0.0, 'default1', NULL), (2, NULL, NULL, NULL, 1, 0, 0.0, 'default2', 'default2'), (3, 'default2', NULL, 1, 1, NULL, 0.0, 'default1', NULL);
INSERT INTO city (city_id, county_id, name, white, black, amerindian, asian, multiracial, hispanic) VALUES (1, 1, NULL, 1.0, 1.0, 0.0, 0.0, 0.0, 1.0), (0, 0, NULL, NULL, 0.0, 0.0, NULL, 1.0, NULL), (2, 3, 'default2', NULL, NULL, 0.0, NULL, NULL, 1.0), (3, 2, 'default1', 1.0, 0.0, 1.0, NULL, NULL, NULL), (4, NULL, NULL, 0.0, 0.0, 1.0, NULL, 0.0, 1.0), (5, 3, 'default1', NULL, 0.0, 0.0, NULL, NULL, NULL), (6, 2, 'default2', 0.0, 1.0, 1.0, 1.0, 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT white, crime_rate FROM (SELECT LHS.city_id AS city_id, LHS.county_id AS county_id, LHS.name AS name, LHS.white AS white, LHS.black AS black, LHS.amerindian AS amerindian, LHS.asian AS asian, LHS.multiracial AS multiracial, LHS.hispanic AS hispanic, RHS.name AS name_other, RHS.population AS population, RHS.police_officers AS police_officers, RHS.residents_per_officer AS residents_per_officer, RHS.case_burden AS case_burden, RHS.crime_rate AS crime_rate, RHS.police_force AS police_force, RHS.location AS LOCATION FROM city AS LHS INNER JOIN county_public_safety AS RHS ON (LHS.county_id = RHS.county_id)) ORDER BY white, crime_rate NULLS LAST;

/*
Gold Result:
(None, 0.0)
(None, 0.0)
(None, None)
(0.0, 0.0)
(1.0, 0.0)
(1.0, 0.0)
*/

-- Prediction Query
SELECT T1.White, T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID = T2.County_ID;

/*
Prediction Result:
(None, None)
(1.0, 0.0)
(None, 0.0)
(1.0, 0.0)
(None, 0.0)
(0.0, 0.0)
*/