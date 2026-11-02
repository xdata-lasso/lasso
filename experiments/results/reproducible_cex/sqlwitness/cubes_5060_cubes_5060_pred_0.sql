-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (1, 0.0, 'default2', 'default1', NULL, 'default2', 'default2', 'default2'), (3, 0.0, 'default2', NULL, NULL, NULL, 'default2', 'default1');
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (1, NULL, NULL, 'default1'), (3, NULL, 3.0, 'default1'), (2, NULL, NULL, NULL), (0, 'default2', 1.0, 'default1');
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (1, 0, 3, 'default1', 'default2', 3.0, 'default2'), (2, NULL, 1, NULL, NULL, 1.0, 'default2'), (3, 0, 1, 'default1', NULL, NULL, 'default1'), (0, 3, 1, 'default1', 'default1', 3.0, 'default2'), (4, 0, NULL, 'default1', 'default1', NULL, NULL), (5, 1, 1, 'default2', 'default1', 0.0, NULL), (6, 0, NULL, 'default2', 'default1', 1.0, NULL), (7, 1, NULL, NULL, NULL, 0.0, NULL), (8, 1, 3, 'default2', NULL, NULL, 'default2'), (9, 1, NULL, 'default2', 'default2', 0.0, NULL), (10, 3, NULL, NULL, NULL, 3.0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM (SELECT county_id, county_name, population, zip_code, n, county_id AS district FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.n AS n FROM county AS LHS INNER JOIN (SELECT district, COUNT(*) AS n FROM election GROUP BY district) AS RHS ON (LHS.county_id = RHS.district))) WHERE (n >= 2) ORDER BY county_name;

/*
Gold Result:
(None,)
(None,)
('default2',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District GROUP BY T1.County_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('default2',)
(None,)
(None,)
*/