-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1036, 'Sharon James', 1037.5, '59930');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1048, 'Kristin Cohen', 1049.5, '07832');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1038, 1039.5, 'prove', 'they', 'his', 'commercial', 'hospital', 'hear');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1050, 1051.5, 'drop', 'term', 'almost', 'support', 'four', 'institution');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1044, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1040, 1036, 1038, 'determine', 'religious', 1041.5, 'example');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1046, 1036, 1044, 'hundred', 'expect', 1047.5, 'wish');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1052, 1048, 1050, 'executive', 'attorney', 1053.5, 'development');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate, county_name FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS INNER JOIN election AS RHS ON (LHS.county_id = RHS.district)) ORDER BY delegate, county_name NULLS LAST;

/*
Gold Result:
('attorney', 'Kristin Cohen')
('expect', 'Sharon James')
('religious', 'Sharon James')
*/

-- Prediction Query
SELECT T2.Delegate, T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District;

/*
Prediction Result:
('religious', 'Sharon James')
('expect', 'Sharon James')
('attorney', 'Kristin Cohen')
*/