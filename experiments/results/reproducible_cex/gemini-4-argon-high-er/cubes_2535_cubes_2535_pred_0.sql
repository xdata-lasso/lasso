-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'County A', 1000.0, '10001');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'County B', 2000.0, '10002');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2020.0, 'Dem', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 2, 1, 'County B', 'Del B', 2018.0, 'Rules');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 1, 1, 'County A', 'Del A', 2019.0, 'Finance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT district FROM election ORDER BY district;

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT DISTINCT District FROM election;

/*
Prediction Result:
(2,)
(1,)
*/