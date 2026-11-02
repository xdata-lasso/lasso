-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county_public_safety (county_id, name, population, police_officers, residents_per_officer, case_burden, crime_rate, police_force, location) VALUES (1, 'default1', 1, NULL, NULL, 0, 1.0, 'default2', 'default2'), (0, 'West', 1, 0, 0, 0, 0.0, 'East', 'default1'), (2, 'default2', 0, NULL, 0, 0, 0.0, 'default1', 'default2'), (3, 'default1', 1, NULL, 1, 1, 0.0, 'default2', 'West');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East' AND "location" = 'West') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
('default2',)
*/

-- Prediction Query
SELECT Police_force FROM county_public_safety WHERE LOCATION = 'East' INTERSECT SELECT Police_force FROM county_public_safety WHERE LOCATION = 'West';

/*
Prediction Result:
*/