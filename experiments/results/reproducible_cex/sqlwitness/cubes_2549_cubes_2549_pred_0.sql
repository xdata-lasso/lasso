-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (2, NULL, 'default2', NULL, 'default2', 'default1', 'default1', 'default2'), (1, 1.0, NULL, 'default1', 'default2', 'default2', 'default1', 'default1'), (0, NULL, 'default2', 'default1', 'default1', 'default2', 'default2', 'default1'), (3, 2.0, 'default1', 'default1', NULL, NULL, 'default1', 'default2'), (4, 2.0, 'default1', NULL, NULL, 'default1', 'default2', 'default1'), (5, 2.0, 'default1', NULL, 'default2', 'default2', NULL, 'default2'), (6, NULL, NULL, NULL, 'default1', 'default2', 'default1', 'default1'), (7, 0.0, NULL, NULL, 'default2', 'default1', NULL, 'default1'), (8, 1.0, 'default1', NULL, 'default1', 'default2', NULL, 'default1'), (9, 2.0, 'default1', NULL, 'default2', 'default2', 'default2', 'default1');
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (0, 'default1', 0.0, NULL), (2, 'default1', NULL, 'default2'), (1, 'default2', 0.0, NULL), (3, 'default1', 0.0, 'default2'), (4, 'default2', 2.0, 'default1'), (5, NULL, 0.0, 'default1');
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (2, 1, 8, 'default2', 'default1', 2.0, NULL), (0, 3, NULL, 'default1', 'default2', 1.0, NULL), (1, 5, NULL, NULL, 'default1', NULL, 'default1'), (3, 1, 1, NULL, NULL, NULL, NULL), (4, 4, 2, 'default2', 'default1', 0.0, 'default1'), (5, 1, 9, NULL, NULL, 2.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate FROM election WHERE (district = 1) ORDER BY delegate, election.election_id NULLS LAST;

/*
Gold Result:
(None,)
(None,)
('default1',)
*/

-- Prediction Query
SELECT Delegate FROM election WHERE District = 1;

/*
Prediction Result:
('default1',)
(None,)
(None,)
*/