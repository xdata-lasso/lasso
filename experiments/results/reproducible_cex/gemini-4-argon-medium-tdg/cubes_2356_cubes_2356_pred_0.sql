-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'Apex County', 50000, 120, 416, 50, 12.5, 'State Police', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'Beta County', 60000, 150, 400, 60, 15.0, 'Alpha Force', 'North');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'Gamma County', 40000, 100, 400, 40, 10.0, 'Alpha Force', 'South');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (4, 'Delta County', 70000, 200, 350, 30, 8.5, 'East Exclusive Force', 'East');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (5, 'Epsilon County', 30000, 80, 375, 45, 11.0, NULL, 'West');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha Force',)
('State Police',)
*/

-- Prediction Query
SELECT DISTINCT Police_force FROM county_public_safety WHERE LOCATION <> 'East';

/*
Prediction Result:
('State Police',)
('Alpha Force',)
(None,)
*/