-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'Mercer', 120000, 300, 400, 50, 12.5, 'State Police', 'West');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'Bucks', 85000, 170, 500, 40, 8.2, 'County Sheriff', 'Central');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'York', 95000, 190, 500, 45, 9.1, 'State Police', 'North');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (4, 'Essex', 200000, 500, 400, 60, 15.0, 'East Metro PD', 'East');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (101, 1, 'Trenton', 45.0, 30.0, 0.5, 5.5, 4.0, 15.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (102, 1, 'Princeton', 65.0, 8.0, 0.2, 18.8, 3.0, 5.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (103, 4, 'Newark', 25.0, 48.0, 0.4, 2.6, 4.0, 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "police_force" FROM "county_public_safety" WHERE ("location" <> 'East') ORDER BY police_force, "police_force" NULLS LAST;

/*
Gold Result:
('County Sheriff',)
('State Police',)
*/

-- Prediction Query
SELECT DISTINCT Police_force FROM county_public_safety WHERE LOCATION <> 'East';

/*
Prediction Result:
('State Police',)
('County Sheriff',)
*/