-- Schema DDL
CREATE TABLE "county_public_safety" ("County_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Population" INTEGER, "Police_officers" INTEGER, "Residents_per_officer" INTEGER, "Case_burden" INTEGER, "Crime_rate" REAL, "Police_force" TEXT, "Location" TEXT);

CREATE TABLE "city" ("City_ID" INTEGER PRIMARY KEY, "County_ID" INTEGER, "Name" TEXT, "White" REAL, "Black" REAL, "Amerindian" REAL, "Asian" REAL, "Multiracial" REAL, "Hispanic" REAL, FOREIGN KEY ("County_ID") REFERENCES "county_public_safety" ("County_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county_public_safety (County_ID, Name, Population, Police_officers, Residents_per_officer, Case_burden, Crime_rate, Police_force, Location) VALUES (1, 'Mercer', 100000, 200, 500, 50, 12.5, 'Mercer PD', 'North');
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (1, 1, 'Oakville', 60.0, 10.0, 1.0, 5.0, 4.0, 20.0);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (2, 1, 'Pinecrest', 45.0, 15.5, 0.5, 6.8, 2.0, 30.2);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (3, 1, 'Mapleton', 75.0, 10.1, 1.5, 4.0, 4.0, 5.4);
INSERT INTO city (City_ID, County_ID, Name, White, Black, Amerindian, Asian, Multiracial, Hispanic) VALUES (4, 1, 'Riverdale', 40.0, 4.2, 0.8, 7.0, 3.0, 45.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hispanic FROM city WHERE (black > 10.0) ORDER BY hispanic, city.city_id NULLS LAST;

/*
Gold Result:
(5.4,)
(30.2,)
*/

-- Prediction Query
SELECT Hispanic FROM city WHERE Black > 10;

/*
Prediction Result:
(30.2,)
(5.4,)
*/