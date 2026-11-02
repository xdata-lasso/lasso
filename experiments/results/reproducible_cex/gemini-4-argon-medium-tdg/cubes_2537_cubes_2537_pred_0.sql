-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (10, 'Adams', 50000.0, '10001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (20, 'Baker', 75000.0, '10002');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (100, 2020.0, 'Dem', 'Smith', 'Jones', 'Taylor', 'Brown', 'Wilson');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (200, 2022.0, 'Rep', 'Davis', 'Miller', 'Moore', 'Anderson', 'Thomas');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (3, 10, 200, 'Adams', 'Alice', 2018.0, 'Finance');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 20, 100, 'Baker', 'Charlie', 2010.0, 'Health');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 10, 100, 'Adams, Baker', 'Bob', 2014.0, 'Education');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT election_id, counties_represented, district, delegate, party, first_elected, committee FROM election ORDER BY election_id;

/*
Gold Result:
(1, 'Baker', 20, 'Charlie', 100, 2010.0, 'Health')
(2, 'Adams, Baker', 10, 'Bob', 100, 2014.0, 'Education')
(3, 'Adams', 10, 'Alice', 200, 2018.0, 'Finance')
*/

-- Prediction Query
SELECT * FROM election;

/*
Prediction Result:
(1, 20, 100, 'Baker', 'Charlie', 2010.0, 'Health')
(2, 10, 100, 'Adams, Baker', 'Bob', 2014.0, 'Education')
(3, 10, 200, 'Adams', 'Alice', 2018.0, 'Finance')
*/