-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1, 'Troy Liu', 1066.5, '35023');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1067, 1068.5, 'month', 'sound', 'could', 'movement', 'while', 'born');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1072, 1073.5, 'color', 'notice', 'start', 'win', 'nice', 'why');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1069, 1, 1067, 'a', 'process', 1070.5, 'fire');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1074, 1, 1072, 'truth', 'middle', 1071.5, 'game');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate FROM election WHERE (district = 1) ORDER BY delegate, election.election_id NULLS LAST;

/*
Gold Result:
('middle',)
('process',)
*/

-- Prediction Query
SELECT Delegate FROM election WHERE District = 1;

/*
Prediction Result:
('process',)
('middle',)
*/