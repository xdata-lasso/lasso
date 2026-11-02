-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1014, 'Kimberly Dudley', 1015, 1016, 1017, 1018, 1020.5, 'human', '327 Nelson Route
Lake Mark, WI 07832');
INSERT INTO "county_public_safety" ("county_id", "name", "population", "police_officers", "residents_per_officer", "case_burden", "crime_rate", "police_force", "location") VALUES (1020, 'Michael Miles', 1016, 1017, 1018, 1019, 1019.5, 'result', '959 Janet Cape Apt. 413
South Joshuastad, GA 49021');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM county_public_safety ORDER BY crime_rate, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(1019.5,)
(1020.5,)
*/

-- Prediction Query
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(1020.5,)
(1019.5,)
*/