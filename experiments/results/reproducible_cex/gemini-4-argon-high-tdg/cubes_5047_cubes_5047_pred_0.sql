-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Zebra', 2000.0, '90001');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Alpha', 2000.0, '90002');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (3, 'Alpha', 2000.0, '90003');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (4, 'Middle', 1500.0, '90001');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2022.0, 'Republican', 'Clark', 'Lewis', 'Walker', 'Hall', 'Allen');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 1, 1, 'Zebra', 'Davis', 2014.0, 'Ways and Means');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 2, 1, 'Alpha', 'Evans', 2020.0, 'Health');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT county_name FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, LHS.maxpopulation AS maxpopulation, RHS.county_id AS county_id_other, RHS.county_name AS county_name_other, RHS.population AS population_other, RHS.zip_code AS zip_code_other, RHS.maxpopulation AS maxpopulation_other FROM (SELECT county_id, county_name, population, zip_code, MAX(population) OVER () AS maxpopulation FROM county) AS LHS CROSS JOIN (SELECT county_id, county_name, population, zip_code, MAX(population) OVER () AS maxpopulation FROM county) AS RHS) WHERE (population >= maxpopulation_other) ORDER BY county_name;

/*
Gold Result:
('Alpha',)
('Zebra',)
*/

-- Prediction Query
SELECT County_name FROM county ORDER BY Population DESC, county.county_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('Zebra',)
*/