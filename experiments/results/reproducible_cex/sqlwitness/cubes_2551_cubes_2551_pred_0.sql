-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (1, NULL, 'default2', 'default2', 'default2', 'default1', 'default2', 'default2'), (0, 0.0, 'Democratic', 'Democratic', 'Democratic', 'default1', 'default2', 'default2'), (2, 0.0, 'default1', NULL, 'default1', 'Democratic', 'default2', 'default2'), (3, 1.0, NULL, 'Democratic', 'default1', NULL, 'default1', 'Democratic'), (4, NULL, 'Democratic', NULL, 'default1', 'default2', NULL, 'default1'), (5, 0.0, 'default2', 'Democratic', NULL, 'default1', 'default2', NULL), (6, NULL, 'default2', 'default2', 'default1', 'default2', NULL, 'default2'), (7, 0.0, 'Democratic', NULL, 'Democratic', 'Democratic', 'default2', NULL), (8, 1.0, 'default1', 'default1', 'default2', 'Democratic', NULL, 'default1'), (9, 0.0, 'default1', NULL, 'default1', NULL, 'default1', 'default2'), (10, 1.0, 'Democratic', NULL, 'Democratic', 'default2', 'default2', 'default2'), (11, 1.0, 'default2', 'default1', 'default2', 'default2', 'default2', NULL), (12, 1.0, NULL, 'Democratic', 'default1', 'Democratic', 'default2', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lieutenant_governor", "comptroller" FROM "party" WHERE ("party" = 'Democratic') ORDER BY lieutenant_governor, party.party_id NULLS LAST;

/*
Gold Result:
('Democratic', 'default1')
('Democratic', 'Democratic')
('Democratic', 'default2')
('default1', 'default2')
*/

-- Prediction Query
SELECT Lieutenant_Governor, Comptroller FROM party WHERE Party = 'Democratic';

/*
Prediction Result:
('Democratic', 'default1')
('default1', 'default2')
('Democratic', 'Democratic')
('Democratic', 'default2')
*/