-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'County A', 50000, 100, 500, 20, 3.5, 'Force A', 'North');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (10, 1, 'City 1', 50.0, 9.9, 1.0, 2.0, 1.0, 15.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (20, 1, 'City 2', 50.0, 10.0, 1.0, 2.0, 1.0, 25.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (30, 1, 'City 3', 50.0, 10.01, 1.0, 2.0, 1.0, 35.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (40, 1, 'City 4', 50.0, 20.0, 1.0, 2.0, 1.0, 5.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (50, 1, 'City 5', 50.0, NULL, 1.0, 2.0, 1.0, 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hispanic FROM city WHERE (black > 10.0) ORDER BY hispanic, city.city_id NULLS LAST;

/*
Gold Result:
(5.0,)
(35.0,)
*/

-- Prediction Query
SELECT Hispanic FROM city WHERE Black > 10;

/*
Prediction Result:
(35.0,)
(5.0,)
*/