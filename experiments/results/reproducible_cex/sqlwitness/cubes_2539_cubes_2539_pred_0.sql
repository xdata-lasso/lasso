-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (0, NULL, NULL, NULL, 'default1', 'default2', 'default1', 'default2'), (1, 0.0, 'default1', NULL, 'default1', 'default2', NULL, NULL);
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (1, NULL, 0.0, 'default1'), (0, 'default2', 0.0, NULL);
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (1, 1, 0, 'default1', 'default1', 1.0, 'default2'), (0, 1, 1, NULL, 'default2', 0.0, NULL), (2, 1, NULL, NULL, 'default1', NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate, committee FROM election ORDER BY delegate, election.election_id NULLS LAST;

/*
Gold Result:
('default1', 'default2')
('default1', 'default2')
('default2', None)
*/

-- Prediction Query
SELECT Delegate, Committee FROM election;

/*
Prediction Result:
('default2', None)
('default1', 'default2')
('default1', 'default2')
*/