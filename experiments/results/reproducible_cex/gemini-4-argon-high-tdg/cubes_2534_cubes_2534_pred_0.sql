-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (10, 'Montgomery', 1050000.0, '20850');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (20, 'Howard', 325000.0, '21042');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (30, 'Frederick', 270000.0, '21701');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2020.0, 'Democratic', 'Smith', 'Jones', 'Taylor', 'Brown', 'Wilson');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (100, 20, 1, 'Montgomery', 'Miller', 2014.0, 'Finance');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (200, 10, 1, 'Howard', 'Adams', 2018.0, 'Judiciary');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (300, 20, NULL, 'Frederick', 'Adams', 2016.0, 'Education');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (400, NULL, 1, 'Howard', 'Baker', 2020.0, 'Health');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate, county_name FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS INNER JOIN election AS RHS ON (LHS.county_id = RHS.district)) ORDER BY delegate, county_name NULLS LAST;

/*
Gold Result:
('Adams', 'Howard')
('Adams', 'Montgomery')
('Miller', 'Howard')
*/

-- Prediction Query
SELECT T2.Delegate, T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District;

/*
Prediction Result:
('Miller', 'Howard')
('Adams', 'Montgomery')
('Adams', 'Howard')
*/