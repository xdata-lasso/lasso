-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Small County A', 45000.0, '10001');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Small County B', 85000.0, '10002');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (3, 'Large County C', 250000.0, '10003');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (10, 2020.0, 'Democratic', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 3, 10, 'Large County C', 'Zoe Adams', 2012.0, 'Finance');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 1, 10, 'Small County A', 'Alice Baker', 2018.0, 'Rules');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (3, 2, NULL, 'Small County B', 'Bob Carter', 2015.0, 'Health');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (4, 1, 10, 'Small County A', 'Alice Baker', 2020.0, 'Ways and Means');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT delegate FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.election_id AS election_id, RHS.counties_represented AS counties_represented, RHS.district AS district, RHS.delegate AS delegate, RHS.party AS party, RHS.first_elected AS first_elected, RHS.committee AS committee FROM county AS LHS CROSS JOIN election AS RHS) WHERE (population <= 100000.0) ORDER BY delegate;

/*
Gold Result:
('Alice Baker',)
('Bob Carter',)
('Zoe Adams',)
*/

-- Prediction Query
SELECT T2.Delegate FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T1.Population < 100000;

/*
Prediction Result:
('Alice Baker',)
('Bob Carter',)
('Alice Baker',)
*/