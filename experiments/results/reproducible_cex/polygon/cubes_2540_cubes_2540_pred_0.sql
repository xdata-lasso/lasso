-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (26, '22', 50001, '23');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (28, 26, '26', '26', '26', '26', '26', '26');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (24, 26, 28, '25', '27', 29, '30');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n AS count_distinct_t2_delegate_ FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, LHS.election_id AS election_id, LHS.counties_represented AS counties_represented, LHS.district AS district, LHS.delegate AS delegate, LHS.party AS party, LHS.first_elected AS first_elected, LHS.committee AS committee, RHS.n AS n FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.district AS district, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS CROSS JOIN election AS RHS) AS LHS CROSS JOIN (SELECT COUNT(*) AS n FROM county WHERE (population <> 50000.0)) AS RHS) ORDER BY count_distinct_t2_delegate_;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT T2.Delegate) FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T1.Population > 50000;

/*
Prediction Result:
(1,)
*/