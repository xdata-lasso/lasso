-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county_public_safety (county_id, name, population, police_officers, residents_per_officer, case_burden, crime_rate, police_force, location) VALUES (1, 'default1', 1, 0, 1, 0, NULL, 'default2', NULL), (0, 'default1', 0, 1, 1, 1, 1.0, NULL, 'default2'), (2, NULL, 0, 0, 0, NULL, 0.0, 'default2', 'default2'), (3, 'default1', 0, 1, 0, 0, NULL, 'default2', NULL), (4, 'default1', NULL, NULL, 1, 1, 0.0, 'default1', 'default1'), (5, 'East', 0, 1, NULL, NULL, 1.0, NULL, NULL), (6, 'East', NULL, 0, 1, 0, NULL, 'East', 'default2'), (7, 'default1', 1, 1, 0, 0, NULL, NULL, 'East'), (8, 'default2', NULL, 1, 0, 1, 1.0, 'default1', 'East'), (9, 'default2', 0, 1, NULL, NULL, 0.0, 'East', 'East');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
(None,)
('East',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT Police_force FROM county_public_safety WHERE LOCATION <> 'East';

/*
Prediction Result:
(None,)
('default2',)
('default1',)
('East',)
*/