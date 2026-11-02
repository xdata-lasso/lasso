-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering (anti-correlation between County_ID and Name), duplicate names (SELECT DISTINCT mutants), and unreferenced vs multi-referenced counties (JOIN/EXISTS mutants).
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'Zeta County', 100000, 200, 500, 45, 2.5, 'Zeta PD', 'North');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'Alpha County', 50000, 100, 500, 30, 1.2, 'Alpha PD', 'South');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'Beta County', 75000, 150, 500, 60, 3.8, 'Beta Sheriff', 'East');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (4, 'Alpha County', 120000, 300, 400, 25, 0.9, 'Metro Police', 'West');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (1, 1, 'Zeta City 1', 60.5, 15.0, 1.0, 10.5, 3.0, 10.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (2, 1, 'Zeta City 2', 50.0, 20.0, 1.5, 12.0, 4.5, 12.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (3, 2, 'Alpha City', 70.0, 10.0, 0.5, 5.0, 2.5, 12.0);
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
('Alpha County',)
('Zeta County',)
('Beta County',)
('Alpha County',)
*/