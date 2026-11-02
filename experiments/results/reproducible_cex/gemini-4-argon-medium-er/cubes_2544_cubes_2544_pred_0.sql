-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'B_County', 2000.0, '11111');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'A_County', 1000.0, '22222');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name, population FROM county ORDER BY county_name, county.county_id NULLS LAST;

/*
Gold Result:
('A_County', 1000.0)
('B_County', 2000.0)
*/

-- Prediction Query
SELECT County_name, Population FROM county;

/*
Prediction Result:
('B_County', 2000.0)
('A_County', 1000.0)
*/