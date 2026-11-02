-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (1, 'default2', 0.0, 'default1'), (0, 'default1', 1.0, 'default1'), (2, NULL, 0.0, NULL), (3, 'default2', NULL, 'default2'), (4, 'default1', 0.0, 'Howard'), (5, 'Howard', 0.0, 'Howard'), (6, 'Howard', 0.0, NULL), (7, 'default1', 0.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "zip_code" FROM "county" WHERE ("county_name" = 'Howard') ORDER BY zip_code, county.county_id NULLS LAST;

/*
Gold Result:
(None,)
('Howard',)
*/

-- Prediction Query
SELECT Zip_code FROM county WHERE County_name = 'Howard';

/*
Prediction Result:
('Howard',)
(None,)
*/