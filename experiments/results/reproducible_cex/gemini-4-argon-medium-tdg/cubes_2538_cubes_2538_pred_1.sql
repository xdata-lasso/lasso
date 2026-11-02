-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (30, 'Howard', NULL, '00000');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (10, 'Anne Arundel', -500.0, NULL);
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (20, 'Calvert', 0.0, '');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (40, NULL, 12000.0, '21601');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM county ORDER BY county_name, county.county_id NULLS LAST;

/*
Gold Result:
(None,)
('Anne Arundel',)
('Calvert',)
('Howard',)
*/

-- Prediction Query
SELECT County_name FROM county ORDER BY Population ASC, county.county_id NULLS LAST;

/*
Prediction Result:
('Howard',)
('Anne Arundel',)
('Calvert',)
(None,)
*/