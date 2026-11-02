-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ascending order, duplicate values (to catch DISTINCT), and negative/zero/positive REAL values.
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'County A', 10000, 50, 200, 10, 45.5, 'Force A', 'North');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'County B', 20000, 100, 200, 15, 12.3, 'Force B', 'South');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'County C', 15000, 75, 200, 12, 45.5, 'Force C', 'East');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (4, 'County D', 5000, 25, 200, 5, 0.0, 'Force D', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (5, 'County E', 8000, 40, 200, 8, -5.2, 'Force E', 'Central');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM county_public_safety ORDER BY crime_rate, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(-5.2,)
(0.0,)
(12.3,)
(45.5,)
(45.5,)
*/

-- Prediction Query
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(0.0,)
(-5.2,)
(45.5,)
(45.5,)
(12.3,)
*/