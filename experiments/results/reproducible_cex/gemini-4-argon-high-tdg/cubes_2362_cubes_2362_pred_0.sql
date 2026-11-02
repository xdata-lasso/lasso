-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'Alpha', 50000, 100, 500, 85, 4.5, 'Metro', 'North');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (2, 'Beta', 90000, 300, 300, 40, 2.1, 'State', 'South');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (3, 'Gamma', 20000, 200, 100, 60, 8.9, 'Central', 'East');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (4, 'Delta', 70000, 175, 400, 40, 6.3, 'Local', 'West');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (1, 2, 'Betaville', 60.5, 15.2, 1.1, 8.4, 3.8, 11.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (2, 3, 'Gammaburg', 45.0, 25.0, 2.0, 10.0, 5.0, 13.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (3, 3, 'East Gamma', 50.0, 20.0, 1.5, 9.5, 4.0, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT case_burden FROM county_public_safety ORDER BY case_burden, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(40,)
(40,)
(60,)
(85,)
*/

-- Prediction Query
SELECT Case_burden FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(40,)
(40,)
(85,)
(60,)
*/