-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (0, 1.0, NULL, NULL, NULL, 'default2', 'default2', 'default1'), (1, NULL, NULL, 'default2', NULL, 'default2', 'default1', 'default2'), (2, 1.0, NULL, NULL, 'default2', 'default2', NULL, NULL), (3, 0.0, NULL, NULL, 'default1', NULL, NULL, NULL), (4, 0.0, 'default1', NULL, 'default2', 'default1', 'default2', 'default2');
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (1, 'default1', 1.0, 'default2'), (0, 'default2', 0.0, NULL), (2, 'default2', 1.0, NULL), (3, 'default1', 0.0, 'default2'), (4, NULL, 1.0, 'default2'), (5, 'default1', NULL, NULL), (6, 'default1', 0.0, 'default2');
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (0, 2, NULL, NULL, 'default1', 0.0, NULL), (1, 1, 0, 'default1', 'default1', 0.0, 'default2'), (2, 6, NULL, 'default2', 'default2', 1.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate, county_name FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS INNER JOIN election AS RHS ON (LHS.county_id = RHS.district)) ORDER BY delegate, county_name NULLS LAST;

/*
Gold Result:
('default1', 'default1')
('default1', 'default2')
('default2', 'default1')
*/

-- Prediction Query
SELECT T2.Delegate, T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District;

/*
Prediction Result:
('default1', 'default2')
('default1', 'default1')
('default2', 'default1')
*/