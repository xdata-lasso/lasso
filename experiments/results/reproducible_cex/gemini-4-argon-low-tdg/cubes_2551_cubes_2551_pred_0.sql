-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests exact string matching, case sensitivity, leading/trailing spaces, NULLs in WHERE, and INNER JOIN vs standalone table access (parties without election records).
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2000.0, 'Democratic', 'Gov A', 'LG B', 'Comp X', 'AG A', 'Sen A');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (2, 2004.0, 'Republican', 'Gov B', 'LG A', 'Comp Y', 'AG B', 'Sen B');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (3, 2008.0, 'democratic', 'Gov C', 'LG C', 'Comp Z', 'AG C', 'Sen C');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (4, 2012.0, 'Democratic ', 'Gov D', 'LG D', 'Comp W', 'AG D', 'Sen D');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (5, 2016.0, NULL, 'Gov E', 'LG E', 'Comp V', 'AG E', 'Sen E');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (6, 2020.0, 'Democratic', 'Gov F', 'LG A', 'Comp U', 'AG F', 'Sen F');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "lieutenant_governor", "comptroller" FROM "party" WHERE ("party" = 'Democratic') ORDER BY lieutenant_governor, party.party_id NULLS LAST;

/*
Gold Result:
('LG A', 'Comp U')
('LG B', 'Comp X')
*/

-- Prediction Query
SELECT Lieutenant_Governor, Comptroller FROM party WHERE Party = 'Democratic';

/*
Prediction Result:
('LG B', 'Comp X')
('LG A', 'Comp U')
*/