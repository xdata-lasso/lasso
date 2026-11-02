-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county_public_safety (county_id, name, population, police_officers, residents_per_officer, case_burden, crime_rate, police_force, location) VALUES (1, 'default1', 1, NULL, 0, 1, 0.0, 'default1', 'default1'), (0, NULL, 0, NULL, 0, NULL, 1.0, 'default2', 'default1'), (2, NULL, NULL, NULL, 1, 1, NULL, 'default2', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT case_burden FROM county_public_safety ORDER BY case_burden, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(None,)
(1,)
(1,)
*/

-- Prediction Query
SELECT Case_burden FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(1,)
(None,)
(1,)
*/