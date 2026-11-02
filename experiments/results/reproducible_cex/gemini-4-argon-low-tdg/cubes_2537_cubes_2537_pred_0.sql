-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Allegany', 75000.0, '21502');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Baltimore', 800000.0, '21201');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Carroll', 167000.0, '21157');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (10, 2018.0, 'Democratic', 'Smith', 'Johnson', 'Williams', 'Brown', 'Jones');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (20, 2020.0, 'Republican', 'Miller', 'Davis', 'Garcia', 'Rodriguez', 'Wilson');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (30, 2022.0, 'Independent', 'Moore', 'Taylor', 'Anderson', 'Thomas', 'Jackson');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (300, 1, 10, '01A', 'Alice Adams', 2010.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (100, 3, 20, '03C', 'Charlie Clark', 2005.0, 'Judiciary');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (200, 2, 30, '02B', 'Bob Baker', 2015.0, 'Health and Government Operations');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT election_id, counties_represented, district, delegate, party, first_elected, committee FROM election ORDER BY election_id;

/*
Gold Result:
(100, '03C', 3, 'Charlie Clark', 20, 2005.0, 'Judiciary')
(200, '02B', 2, 'Bob Baker', 30, 2015.0, 'Health and Government Operations')
(300, '01A', 1, 'Alice Adams', 10, 2010.0, 'Appropriations')
*/

-- Prediction Query
SELECT * FROM election;

/*
Prediction Result:
(100, 3, 20, '03C', 'Charlie Clark', 2005.0, 'Judiciary')
(200, 2, 30, '02B', 'Bob Baker', 2015.0, 'Health and Government Operations')
(300, 1, 10, '01A', 'Alice Adams', 2010.0, 'Appropriations')
*/