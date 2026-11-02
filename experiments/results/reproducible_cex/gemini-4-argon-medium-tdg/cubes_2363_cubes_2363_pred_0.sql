-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'County A', 1000, 50, 20, 10, 5.5, 'Force A', 'Zeta');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (2, 'County B', 2000, 100, 20, 15, 6.5, 'Force B', 'Alpha');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (3, 'County C', 3000, 100, 30, 20, 7.5, 'Force C', 'Beta');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (1, 1, 'City X', 50.0, 20.0, 1.0, 10.0, 4.0, 15.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (2, 2, 'City Y', 60.0, 10.0, 2.0, 8.0, 5.0, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT LHS.county_id AS county_id, LHS.name AS name, LHS.population AS population, LHS.police_officers AS police_officers, LHS.residents_per_officer AS residents_per_officer, LHS.case_burden AS case_burden, LHS.crime_rate AS crime_rate, LHS.police_force AS police_force, LHS.location AS LOCATION FROM county_public_safety AS LHS INNER JOIN (SELECT police_officers, COUNT(*) AS n FROM county_public_safety GROUP BY police_officers) AS RHS ON (LHS.county_id = RHS.n AND LHS.police_officers = RHS.police_officers)) ORDER BY LOCATION;

/*
Gold Result:
('Alpha',)
('Zeta',)
*/

-- Prediction Query
SELECT LOCATION FROM county_public_safety GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/