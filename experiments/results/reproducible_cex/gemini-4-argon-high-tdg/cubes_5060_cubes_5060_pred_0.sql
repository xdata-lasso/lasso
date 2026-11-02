-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'Wayne', 200.0, '30000');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'Grant', 500.0, '10000');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (3, 'Adams', 300.0, '20000');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (4, 'Baker', 900.0, '40000');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (5, 'Clark', 800.0, '50000');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (4, 2020.0, 'Dem', 'GovA', 'LtGovA', 'CompA', 'AGA', 'SenA');
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (5, 2022.0, 'Rep', 'GovB', 'LtGovB', 'CompB', 'AGB', 'SenB');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (101, 1, 4, '4', 'Del1', 2010.0, 'CommA');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (102, 1, 5, '4', 'Del2', 2012.0, 'CommB');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (103, 2, 4, '5', 'Del3', 2014.0, 'CommC');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (104, 2, 5, '5', 'Del4', 2016.0, 'CommD');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (105, 2, 4, '5', 'Del5', 2018.0, 'CommE');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (106, 2, 5, '5', 'Del6', 2020.0, 'CommF');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (107, 3, 4, '1', 'Del7', 2011.0, 'CommG');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (108, 3, 5, '1', 'Del8', 2013.0, 'CommH');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (109, 3, 4, '1', 'Del9', 2015.0, 'CommI');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (110, 4, 5, '2', 'Del10', 2019.0, 'CommJ');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM (SELECT county_id, county_name, population, zip_code, n, county_id AS district FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.n AS n FROM county AS LHS INNER JOIN (SELECT district, COUNT(*) AS n FROM election GROUP BY district) AS RHS ON (LHS.county_id = RHS.district))) WHERE (n >= 2) ORDER BY county_name;

/*
Gold Result:
('Adams',)
('Grant',)
('Wayne',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District GROUP BY T1.County_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Wayne',)
('Grant',)
('Adams',)
*/