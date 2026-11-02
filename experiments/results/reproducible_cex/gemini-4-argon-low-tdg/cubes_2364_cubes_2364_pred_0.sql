-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact boundary condition (Black = 10.0), duplicate Hispanic values (to kill DISTINCT), and basic ordering.
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'Mercer', 100000, 200, 500, 50, 3.5, 'State', 'East');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (1, 1, 'Alpha', 50.0, 9.9, 1.0, 2.0, 1.0, 5.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (2, 1, 'Beta', 50.0, 10.0, 1.0, 2.0, 1.0, 15.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (3, 1, 'Gamma', 40.0, 10.01, 2.0, 3.0, 1.5, 25.5);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (4, 1, 'Delta', 30.0, 20.0, 3.0, 4.0, 2.0, 12.3);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (5, 1, 'Epsilon', 60.0, 15.0, 0.5, 1.0, 0.5, 12.3);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hispanic FROM city WHERE (black > 10.0) ORDER BY hispanic, city.city_id NULLS LAST;

/*
Gold Result:
(12.3,)
(12.3,)
(25.5,)
*/

-- Prediction Query
SELECT Hispanic FROM city WHERE Black > 10;

/*
Prediction Result:
(25.5,)
(12.3,)
(12.3,)
*/