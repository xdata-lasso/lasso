-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (1, 'default2', 0.0, 'default2'), (0, 'default1', NULL, 'default1'), (2, 'default1', 1.0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM county ORDER BY county_name, county.county_id NULLS LAST;

/*
Gold Result:
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT County_name FROM county ORDER BY Population ASC, county.county_id NULLS LAST;

/*
Prediction Result:
('default1',)
('default2',)
('default1',)
*/