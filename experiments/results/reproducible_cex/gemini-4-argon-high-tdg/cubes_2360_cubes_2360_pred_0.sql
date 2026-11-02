-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'Oak County', 50000, 120, 416, 85, 45.6, 'Oak PD', 'North');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (2, 'Pine County', 30000, 80, 375, 92, 12.4, 'Pine Sheriff', 'South');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (3, 'Maple County', 75000, 200, 375, 60, 28.9, 'Maple Metro', 'East');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (4, 'Cedar County', 20000, 40, 500, 110, 8.1, 'Cedar State', 'West');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (5, 'Birch County', 90000, 300, 300, 40, 62.3, 'Birch Patrol', 'Central');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (10, 1, 'Oakville', 90.0, 4.0, 1.0, 2.0, 1.0, 2.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (20, 2, 'Pinetown', 95.5, 1.5, 0.5, 1.0, 0.5, 1.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (30, 3, 'Maplewood', 89.99, 5.0, 1.0, 2.0, 1.0, 1.01);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (40, 4, 'Cedarburg', 90.01, 3.0, 1.0, 3.0, 1.0, 1.99);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION, RHS.city_id AS city_id, RHS.name AS name_other, RHS.white AS white, RHS.black AS black, RHS.amerindian AS amerindian, RHS.asian AS asian, RHS.multiracial AS multiracial, RHS.hispanic AS hispanic FROM county_public_safety AS LHS INNER JOIN (SELECT * FROM city WHERE (white >= 90.0)) AS RHS ON (LHS.county_id = RHS.county_id)) ORDER BY crime_rate;

/*
Gold Result:
(8.1,)
(12.4,)
(45.6,)
*/

-- Prediction Query
SELECT T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID = T2.County_ID WHERE T1.White > 90;

/*
Prediction Result:
(12.4,)
(8.1,)
*/