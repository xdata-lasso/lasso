-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (19, '26', 100000, NULL);
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (34, '35', NULL, '36');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (16, 19, '19', '19', '19', '19', '19', '19');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (15, 19, '19', '19', '19', '19', '19', '19');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (18, 19, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (17, 19, NULL, NULL, '38', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT delegate FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.district AS district, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS CROSS JOIN election AS RHS) WHERE (population <= 100000.0) ORDER BY delegate;

/*
Gold Result:
(None,)
('38',)
*/

-- Prediction Query
SELECT T2.Delegate FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T1.Population < 100000;

/*
Prediction Result:
*/