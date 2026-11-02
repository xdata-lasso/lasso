-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY primary sort (Lieutenant_Governor ASC) and tie-breaking secondary sort (Party_ID ASC).
-- Also tests DISTINCT vs ALL by including exact duplicate (Lieutenant_Governor, Comptroller) pairs.
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (10, 1990.0, 'Democratic', 'G1', 'LG_Zeta', 'Comp_10', 'AG1', 'S1');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (20, 1994.0, 'Democratic', 'G2', 'LG_Alpha', 'Comp_20', 'AG2', 'S2');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (5, 1998.0, 'Democratic', 'G3', 'LG_Alpha', 'Comp_05', 'AG3', 'S3');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (15, 2002.0, 'Democratic', 'G4', 'LG_Alpha', 'Comp_05', 'AG4', 'S4');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lieutenant_governor", "comptroller" FROM "party" WHERE ("party" = 'Democratic') ORDER BY lieutenant_governor, party.party_id NULLS LAST;

/*
Gold Result:
('LG_Alpha', 'Comp_05')
('LG_Alpha', 'Comp_05')
('LG_Alpha', 'Comp_20')
('LG_Zeta', 'Comp_10')
*/

-- Prediction Query
SELECT Lieutenant_Governor, Comptroller FROM party WHERE Party = 'Democratic';

/*
Prediction Result:
('LG_Alpha', 'Comp_05')
('LG_Zeta', 'Comp_10')
('LG_Alpha', 'Comp_05')
('LG_Alpha', 'Comp_20')
*/