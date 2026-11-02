-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'Zeta County', 100000, 150, 666, 20, 4.5, 'Zeta PD', 'North');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'Alpha County', 50000, 75, 666, 15, 2.1, 'Alpha PD', 'South');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'Alpha County', 80000, 120, 666, 18, 3.2, 'Alpha Metro', 'East');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (4, 'Beta County', 120000, 200, 600, 25, 5.0, 'Beta Sheriff', 'West');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (10, 1, 'Zeta City', 60.5, 10.2, 1.1, 5.5, 2.7, 20.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (20, 1, 'Zeta Town', 70.0, 5.0, 0.5, 4.5, 2.0, 18.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM county_public_safety ORDER BY name, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
('Alpha County',)
('Alpha County',)
('Beta County',)
('Zeta County',)
*/

-- Prediction Query
SELECT Name FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
('Beta County',)
('Zeta County',)
('Alpha County',)
('Alpha County',)
*/