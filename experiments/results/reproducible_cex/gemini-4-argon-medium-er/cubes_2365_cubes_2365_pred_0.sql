-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (1, 'County A', 1000, 10, 100, 50, NULL, 'Force A', 'Loc A');
INSERT INTO "county_public_safety" ("County_ID", "Name", "Population", "Police_officers", "Residents_per_officer", "Case_burden", "Crime_rate", "Police_force", "Location") VALUES (2, 'County B', 2000, 20, 100, 50, 5.5, 'Force B', 'Loc B');
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (1, 1, 'City 1', 50.0, 10.0, 1.0, 5.0, 2.0, 32.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (2, 2, 'City 2', 20.0, 10.0, 1.0, 5.0, 2.0, 62.0);
INSERT INTO "city" ("City_ID", "County_ID", "Name", "White", "Black", "Amerindian", "Asian", "Multiracial", "Hispanic") VALUES (3, 2, 'City 3', 50.0, 10.0, 1.0, 5.0, 2.0, 32.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT white, crime_rate FROM (SELECT LHS.city_id AS city_id, LHS.county_id AS county_id, LHS.name AS name, LHS.white AS white, LHS.black AS black, LHS.amerindian AS amerindian, LHS.asian AS asian, LHS.multiracial AS multiracial, LHS.hispanic AS hispanic, RHS.name AS name_other, RHS.population AS population, RHS.police_officers AS police_officers, RHS.residents_per_officer AS residents_per_officer, RHS.case_burden AS case_burden, RHS.crime_rate AS crime_rate, RHS.police_force AS police_force, RHS.location AS LOCATION FROM city AS LHS INNER JOIN county_public_safety AS RHS ON (LHS.county_id = RHS.county_id)) ORDER BY white, crime_rate NULLS LAST;

/*
Gold Result:
(20.0, 5.5)
(50.0, 5.5)
(50.0, None)
*/

-- Prediction Query
SELECT T1.White, T2.Crime_rate FROM city AS T1 JOIN county_public_safety AS T2 ON T1.County_ID = T2.County_ID;

/*
Prediction Result:
(50.0, None)
(20.0, 5.5)
(50.0, 5.5)
*/