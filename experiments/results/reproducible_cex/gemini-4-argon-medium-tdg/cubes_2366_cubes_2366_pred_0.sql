-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests INNER JOIN vs OUTER JOINs (unmatched parent rows, child rows with NULL foreign key) and basic ordering
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'County_B', 1000, 10, 100, 50, 5.5, 'State', 'East');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (2, 'County_A', 2000, 20, 100, 60, 6.5, 'Local', 'West');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (3, 'Unmatched_County', 3000, 30, 100, 70, 7.5, 'Sheriff', 'North');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (10, 1, 'City_Z', 50.0, 20.0, 1.0, 5.0, 4.0, 20.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (20, 2, 'City_A', 60.0, 10.0, 2.0, 8.0, 5.0, 15.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (30, NULL, 'Orphan_City', 70.0, 5.0, 1.0, 4.0, 5.0, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name AS name___1, name_other AS name___2 FROM (SELECT LHS.city_id AS city_id, LHS.county_id AS county_id, LHS.name AS name, LHS.white AS white, LHS.black AS black, LHS.amerindian AS amerindian, LHS.asian AS asian, LHS.multiracial AS multiracial, LHS.hispanic AS hispanic, RHS.name AS name_other, RHS.population AS population, RHS.police_officers AS police_officers, RHS.residents_per_officer AS residents_per_officer, RHS.case_burden AS case_burden, RHS.crime_rate AS crime_rate, RHS.police_force AS police_force, RHS.location AS LOCATION FROM city AS LHS INNER JOIN county_public_safety AS RHS ON (LHS.county_id = RHS.county_id)) ORDER BY name___1, name___2 NULLS LAST;

/*
Gold Result:
('City_A', 'County_A')
('City_Z', 'County_B')
*/

-- Prediction Query
SELECT T1.Name, T2.Name FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID = T2.County_ID;

/*
Prediction Result:
('City_Z', 'County_B')
('City_A', 'County_A')
*/