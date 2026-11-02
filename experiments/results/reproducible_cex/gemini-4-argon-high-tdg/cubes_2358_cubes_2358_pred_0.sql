-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'County A', 10000, 100, 100, 50, 12.5, 'Zeta Patrol', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'County B', 20000, 200, 100, 60, 25.0, 'Mu Sheriff', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'County C', 30000, 300, 100, 70, 37.5, 'Alpha Police', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (4, 'County D', 40000, 400, 100, 80, 50.0, 'Alpha Police', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (5, 'County E', 50000, 500, 100, 90, 62.5, 'East Guard', 'East');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (6, 'County F', 60000, 600, 100, 100, 75.0, 'North Watch', 'North');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (7, 'County G', 70000, 700, 100, 110, 87.5, 'South Troopers', 'South');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (1, 3, 'Alpha City 1', 60.0, 10.0, 1.0, 9.0, 5.0, 15.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (2, 3, 'Alpha City 2', 55.0, 15.0, 1.0, 9.0, 5.0, 15.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (3, 5, 'East City', 70.0, 10.0, 1.0, 4.0, 5.0, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East' AND "location" = 'West') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
('Alpha Police',)
('Mu Sheriff',)
('Zeta Patrol',)
*/

-- Prediction Query
SELECT Police_force FROM county_public_safety WHERE LOCATION = 'East' INTERSECT SELECT Police_force FROM county_public_safety WHERE LOCATION = 'West';

/*
Prediction Result:
*/