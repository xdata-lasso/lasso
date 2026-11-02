-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Howard', 287085.0, '21042');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (5, 'Talbot', 37782.0, '21601');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (10, 'Frederick', 233385.0, '21701');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (99, 'UnusedCounty', 15000.0, '20000');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (101, 2018.0, 'Democratic', 'Ben Jealous', 'Susan Turnbull', 'Peter Franchot', 'Brian Frosh', 'Ben Cardin');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (102, 2022.0, 'Republican', 'Dan Cox', 'Gordana Schifanelli', 'Barry Glassman', 'Michael Peroutka', 'Chris Chaffee');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 10, 101, '10', 'Kelly Schulz', 2010.0, 'Economic Matters');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 2, 101, '02', 'Shane Pendergrass', 1994.0, 'Health and Government Operations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (3, 10, 102, '10', 'Johnathyon Awkward', 2014.0, 'Appropriations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (4, 5, 102, '05', 'Susan Krebs', 2002.0, 'Ways and Means');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT district FROM election ORDER BY district;

/*
Gold Result:
(2,)
(5,)
(10,)
*/

-- Prediction Query
SELECT DISTINCT District FROM election;

/*
Prediction Result:
(10,)
(2,)
(5,)
*/