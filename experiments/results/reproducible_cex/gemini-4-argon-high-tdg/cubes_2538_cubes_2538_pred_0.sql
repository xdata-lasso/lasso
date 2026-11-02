-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Montgomery', 50000.0, '20850');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Allegany', 75000.0, '21502');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Baltimore', 120000.0, '21201');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, 'Allegany', 30000.0, '21501');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (5, 'Howard', 90000.0, '21042');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2020.0, 'Democratic', 'Smith', 'Jones', 'Taylor', 'Brown', 'Wilson');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, 1, 'Montgomery County', 'Alice', 2018.0, 'Finance');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 1, 1, 'Montgomery County', 'Bob', 2020.0, 'Health');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (3, 2, 1, 'Allegany County', 'Charlie', 2016.0, 'Rules');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM county ORDER BY county_name, county.county_id NULLS LAST;

/*
Gold Result:
('Allegany',)
('Allegany',)
('Baltimore',)
('Howard',)
('Montgomery',)
*/

-- Prediction Query
SELECT County_name FROM county ORDER BY County_name DESC, county.county_id NULLS LAST;

/*
Prediction Result:
('Montgomery',)
('Howard',)
('Baltimore',)
('Allegany',)
('Allegany',)
*/