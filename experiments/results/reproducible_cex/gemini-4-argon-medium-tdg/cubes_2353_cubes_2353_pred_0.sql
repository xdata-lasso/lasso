-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'Alpha', 1000, 10, 100, 50, 5.5, 'Force A', 'Loc A');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (2, 'Beta', 2000, 20, 100, 60, 2.1, 'Force B', 'Loc B');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (3, 'Gamma', 3000, 30, 100, 70, 5.5, 'Force C', 'Loc C');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (4, 'Delta', 4000, 40, 100, 80, 9.8, 'Force D', 'Loc D');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (1, 1, 'City One', 50.0, 20.0, 1.0, 10.0, 4.0, 15.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (2, 1, 'City Two', 60.0, 10.0, 2.0, 10.0, 3.0, 15.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM county_public_safety ORDER BY crime_rate, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(2.1,)
(5.5,)
(5.5,)
(9.8,)
*/

-- Prediction Query
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(5.5,)
(2.1,)
(5.5,)
(9.8,)
*/