-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("County_ID", "Police_officers", "Crime_rate") VALUES (1, 10, 50.0);
INSERT INTO "county_public_safety" ("County_ID", "Police_officers", "Crime_rate") VALUES (2, 20, 10.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM county_public_safety ORDER BY crime_rate, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(10.0,)
(50.0,)
*/

-- Prediction Query
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(50.0,)
(10.0,)
*/