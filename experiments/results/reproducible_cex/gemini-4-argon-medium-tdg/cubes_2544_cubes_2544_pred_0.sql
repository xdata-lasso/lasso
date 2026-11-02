-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic ordering by County_name ASC, tie-breaking by County_Id ASC, and duplicate output rows (to kill SELECT DISTINCT mutants).
-- Also includes a county with no election rows and a county with multiple election rows (to kill INNER JOIN / LEFT JOIN mutants).
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Baltimore', 800000.0, '21201');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Anne Arundel', 500000.0, '21401');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (3, 'Anne Arundel', 600000.0, '21402');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (4, 'Allegany', 75000.0, '21502');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (5, 'Allegany', 75000.0, '21503');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (10, 2020.0, 'Democratic', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (100, 1, 10, 'Baltimore', 'Del 1', 2018.0, 'Approp');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (101, 1, 10, 'Baltimore', 'Del 2', 2016.0, 'Ways');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (102, 2, 10, 'Anne Arundel', 'Del 3', 2014.0, 'Rules');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name, population FROM county ORDER BY county_name, county.county_id NULLS LAST;

/*
Gold Result:
('Allegany', 75000.0)
('Allegany', 75000.0)
('Anne Arundel', 500000.0)
('Anne Arundel', 600000.0)
('Baltimore', 800000.0)
*/

-- Prediction Query
SELECT County_name, Population FROM county;

/*
Prediction Result:
('Baltimore', 800000.0)
('Anne Arundel', 500000.0)
('Anne Arundel', 600000.0)
('Allegany', 75000.0)
('Allegany', 75000.0)
*/