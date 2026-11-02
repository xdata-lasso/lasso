-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'ZeroCounty', 1000.0, '10001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'OneCounty', 2000.0, '10002');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'TwoCounty', 1500.0, '10003');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, 'ThreeCounty', 500.0, '10004');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (10, 2020.0, 'Dem', 'GovA', 'LtA', 'CompA', 'AGA', 'SenA');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (101, 2, 10, '1', 'Del1', 2010.0, 'CommA');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (102, 3, 10, '1', 'Del2', 2012.0, 'CommB');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (103, 3, 10, '1', 'Del3', 2014.0, 'CommC');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (104, 4, 10, '1', 'Del4', 2016.0, 'CommD');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (105, 4, 10, '1', 'Del5', 2018.0, 'CommE');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (106, 4, 10, '1', 'Del6', 2020.0, 'CommF');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM (SELECT county_id, county_name, population, zip_code, n, county_id AS district FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.n AS n FROM county AS LHS INNER JOIN (SELECT district, COUNT(*) AS n FROM election GROUP BY district) AS RHS ON (LHS.county_id = RHS.district))) WHERE (n >= 2) ORDER BY county_name;

/*
Gold Result:
('ThreeCounty',)
('TwoCounty',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District GROUP BY T1.County_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('TwoCounty',)
('ThreeCounty',)
*/