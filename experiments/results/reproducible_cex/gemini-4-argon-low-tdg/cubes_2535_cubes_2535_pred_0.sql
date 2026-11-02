-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Duplicate District values (kills missing DISTINCT), out-of-order insertion (kills missing/DESC ORDER BY), unreferenced County_Id (kills queries selecting from county instead of election), and different Election_ID/Party values (kills wrong column selection).
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (10, 'Alpha', 1000.0, '10001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (20, 'Beta', 2000.0, '10002');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (30, 'Gamma', 3000.0, '10003');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (40, 'Delta', 4000.0, '10004');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2020.0, 'Dem', 'GovA', 'LtA', 'CompA', 'AGA', 'SenA');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (2, 2020.0, 'Rep', 'GovB', 'LtB', 'CompB', 'AGB', 'SenB');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (101, 30, 1, '30', 'DelA', 2018.0, 'CommA');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (102, 10, 2, '10', 'DelB', 2016.0, 'CommB');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (103, 30, 2, '30', 'DelC', 2020.0, 'CommC');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (104, 20, 1, '20', 'DelD', 2014.0, 'CommA');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT district FROM election ORDER BY district;

/*
Gold Result:
(10,)
(20,)
(30,)
*/

-- Prediction Query
SELECT DISTINCT District FROM election;

/*
Prediction Result:
(30,)
(10,)
(20,)
*/