-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ORDER BY delegate ASC, county_name ASC, and specifically tests NULLS LAST behavior on county_name as well as NULL handling in delegate.
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Zeta', 15000.0, '11111');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Alpha', 25000.0, '22222');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (3, NULL, 35000.0, '33333');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (101, 1, NULL, 'Rep 1', 'Alice', 2010.0, 'Rules');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (102, 2, NULL, 'Rep 2', 'Alice', 2012.0, 'Rules');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (103, 3, NULL, 'Rep 3', 'Alice', 2014.0, 'Rules');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (104, 2, NULL, 'Rep 4', 'Bob', 2016.0, 'Ways');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (105, 1, NULL, 'Rep 5', NULL, 2018.0, 'Ways');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT delegate, county_name FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS INNER JOIN election AS RHS ON (LHS.county_id = RHS.district)) ORDER BY delegate, county_name NULLS LAST;

/*
Gold Result:
(None, 'Zeta')
('Alice', 'Alpha')
('Alice', 'Zeta')
('Alice', None)
('Bob', 'Alpha')
*/

-- Prediction Query
SELECT T2.Delegate, T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District;

/*
Prediction Result:
('Alice', 'Zeta')
('Alice', 'Alpha')
('Alice', None)
('Bob', 'Alpha')
(None, 'Zeta')
*/