-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Howard', 325000.0, '21045');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Howard', 150000.0, '21042');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Howard', 200000.0, '21042');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, 'Baltimore', 850000.0, '21201');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2020.0, 'Democratic', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, 1, 'Howard', 'Delegate X', 2014.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 1, 1, 'Howard', 'Delegate Y', 2018.0, 'Judiciary');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "zip_code" FROM "county" WHERE ("county_name" = 'Howard') ORDER BY zip_code, county.county_id NULLS LAST;

/*
Gold Result:
('21042',)
('21042',)
('21045',)
*/

-- Prediction Query
SELECT Zip_code FROM county WHERE County_name = 'Howard';

/*
Prediction Result:
('21045',)
('21042',)
('21042',)
*/