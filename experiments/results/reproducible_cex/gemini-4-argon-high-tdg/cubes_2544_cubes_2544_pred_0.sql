-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Howard', 300000.0, '21042');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Baltimore', 800000.0, '21201');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (3, 'Baltimore', 600000.0, '21202');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (4, 'Baltimore', 700000.0, '21203');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (5, 'Allegany', 75000.0, '21502');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (6, 'Howard', 300000.0, '21043');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2020.0, 'Democratic', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 1, 1, 'Howard', 'Del A', 2018.0, 'Appropriations');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 1, 1, 'Howard', 'Del B', 2020.0, 'Ways and Means');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name, population FROM county ORDER BY county_name, county.county_id NULLS LAST;

/*
Gold Result:
('Allegany', 75000.0)
('Baltimore', 800000.0)
('Baltimore', 600000.0)
('Baltimore', 700000.0)
('Howard', 300000.0)
('Howard', 300000.0)
*/

-- Prediction Query
SELECT County_name, Population FROM county;

/*
Prediction Result:
('Howard', 300000.0)
('Baltimore', 800000.0)
('Baltimore', 600000.0)
('Baltimore', 700000.0)
('Allegany', 75000.0)
('Howard', 300000.0)
*/