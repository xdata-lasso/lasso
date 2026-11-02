-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("County_ID", "Police_force", "Location") VALUES (1, 'LAPD', 'West');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East' AND "location" = 'West') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
('LAPD',)
*/

-- Prediction Query
SELECT Police_force FROM county_public_safety WHERE LOCATION = 'East' INTERSECT SELECT Police_force FROM county_public_safety WHERE LOCATION = 'West';

/*
Prediction Result:
*/