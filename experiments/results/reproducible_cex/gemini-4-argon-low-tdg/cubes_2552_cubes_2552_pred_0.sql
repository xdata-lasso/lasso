-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, duplicate zip_codes (kills DISTINCT), NULL zip_code handling, and lexicographical vs numerical sorting of zip_code.
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Howard', 100000.0, '21043');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Howard', 150000.0, '21042');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Howard', 120000.0, '21042');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, 'Howard', 90000.0, '100000');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (5, 'Howard', 50000.0, NULL);
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (6, 'Montgomery', 200000.0, '20850');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "zip_code" FROM "county" WHERE ("county_name" = 'Howard') ORDER BY zip_code, county.county_id NULLS LAST;

/*
Gold Result:
(None,)
('100000',)
('21042',)
('21042',)
('21043',)
*/

-- Prediction Query
SELECT Zip_code FROM county WHERE County_name = 'Howard';

/*
Prediction Result:
('21043',)
('21042',)
('21042',)
('100000',)
(None,)
*/