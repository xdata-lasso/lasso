-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'Delta County', 50000, 120, 416, 85, 104.5, 'State Police', 'North');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (2, 'Alpha County', 150000, 50, 3000, 40, 3.8, 'Sheriff', 'South');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (3, 'Gamma County', 20000, 300, 66, 150, 27.1, 'Local PD', 'West');
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (4, 'Beta County', 80000, 200, 400, 10, 15.2, 'Metro Police', 'East');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (10, 1, 'Deltaville', 60.5, 15.2, 1.1, 8.4, 3.8, 11.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (11, 1, 'North Delta', 55.0, 20.0, 0.5, 10.0, 4.5, 10.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (12, 2, 'Alphatown', 70.2, 10.1, 0.8, 5.5, 2.4, 11.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT crime_rate FROM county_public_safety ORDER BY crime_rate, county_public_safety.county_id NULLS LAST;

/*
Gold Result:
(3.8,)
(15.2,)
(27.1,)
(104.5,)
*/

-- Prediction Query
SELECT Crime_rate FROM county_public_safety ORDER BY Police_officers ASC, county_public_safety.county_id NULLS LAST;

/*
Prediction Result:
(3.8,)
(104.5,)
(15.2,)
(27.1,)
*/