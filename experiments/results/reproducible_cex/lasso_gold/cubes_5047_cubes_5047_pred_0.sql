-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1038, 'Jennifer Jones', NULL, '84760');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1039, 'Latoya Robbins', NULL, '60643');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1040, 'Jonathan Wilkerson', NULL, '19227');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1044, 'David Hoffman', NULL, '67285');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1045, 'Kevin Hurst', NULL, '65187');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1046, 'Daniel Bright', NULL, '12416');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT county_name FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, LHS.maxpopulation AS maxpopulation, RHS.county_id AS county_id_other, RHS.county_name AS county_name_other, RHS.population AS population_other, RHS.zip_code AS zip_code_other, RHS.maxpopulation AS maxpopulation_other FROM (SELECT county_id, county_name, population, zip_code, MAX(population) OVER () AS maxpopulation FROM county) AS LHS CROSS JOIN (SELECT county_id, county_name, population, zip_code, MAX(population) OVER () AS maxpopulation FROM county) AS RHS) WHERE (population >= maxpopulation_other) ORDER BY county_name;

/*
Gold Result:
*/

-- Prediction Query
SELECT County_name FROM county ORDER BY Population DESC, county.county_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Jennifer Jones',)
*/