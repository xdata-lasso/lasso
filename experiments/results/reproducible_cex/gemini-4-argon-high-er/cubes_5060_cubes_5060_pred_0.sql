-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (Party_ID, Year, Party, Governor, Lieutenant_Governor, Comptroller, Attorney_General, US_Senate) VALUES (1, 2020.0, 'P1', 'G1', 'LG1', 'C1', 'AG1', 'USS1');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (1, 'B', 100.0, '10001');
INSERT INTO county (County_Id, County_name, Population, Zip_code) VALUES (2, 'A', 200.0, '10002');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (1, 1, 1, 'B', 'D1', 2020.0, 'C1');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (2, 1, 1, 'B', 'D2', 2020.0, 'C1');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (3, 2, 1, 'A', 'D3', 2020.0, 'C1');
INSERT INTO election (Election_ID, District, Party, Counties_Represented, Delegate, First_Elected, Committee) VALUES (4, 2, 1, 'A', 'D4', 2020.0, 'C1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM (SELECT county_id, county_name, population, zip_code, n, county_id AS district FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.n AS n FROM county AS LHS INNER JOIN (SELECT district, COUNT(*) AS n FROM election GROUP BY district) AS RHS ON (LHS.county_id = RHS.district))) WHERE (n >= 2) ORDER BY county_name;

/*
Gold Result:
('A',)
('B',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District GROUP BY T1.County_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('B',)
('A',)
*/