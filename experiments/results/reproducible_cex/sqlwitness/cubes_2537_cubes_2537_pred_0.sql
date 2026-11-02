-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (0, 'default1', 0.0, 'default2'), (1, NULL, 0.0, 'default1');
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (1, 0, NULL, NULL, 'default1', NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT election_id, counties_represented, district, delegate, party, first_elected, committee FROM election ORDER BY election_id;

/*
Gold Result:
(1, None, 0, 'default1', None, None, None)
*/

-- Prediction Query
SELECT * FROM election;

/*
Prediction Result:
(1, 0, None, None, 'default1', None, None)
*/