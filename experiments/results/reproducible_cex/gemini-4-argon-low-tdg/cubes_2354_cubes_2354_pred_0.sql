-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic DESC ordering on Police_force, decoupling of Police_force from other numeric/text columns, and queries that incorrectly join with the city table (since County_ID 2 has no cities).
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'Alpha County', 500000, 1000, 500, 100, 50.5, 'Force A', 'Loc Z');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'Beta County', 100000, 200, 100, 20, 10.1, 'Force Z', 'Loc A');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (3, 'Gamma County', 300000, 500, 300, 50, 30.3, 'Force M', 'Loc M');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (1, 1, 'Alpha City 1', 50.0, 20.0, 1.0, 10.0, 4.0, 15.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (2, 1, 'Alpha City 2', 60.0, 10.0, 1.0, 10.0, 4.0, 15.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (3, 3, 'Gamma City', 70.0, 5.0, 1.0, 5.0, 4.0, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM county_public_safety ORDER BY police_force DESC, county_public_safety.county_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('Beta County',)
*/

-- Prediction Query
SELECT Name FROM county_public_safety ORDER BY Population DESC, county_public_safety.county_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha County',)
*/