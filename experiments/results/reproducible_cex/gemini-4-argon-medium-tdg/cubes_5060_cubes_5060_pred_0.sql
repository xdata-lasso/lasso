-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Zeta', 10000.0, '10001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Alpha', 50000.0, '10002');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Beta', 30000.0, '10003');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, 'Gamma', 20000.0, '10004');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (10, 2020.0, 'Democratic', 'Gov A', 'Lt A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (101, 2, 10, 'Alpha', 'Del 1', 2018.0, 'Finance');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (102, 1, 10, 'Zeta', 'Del 2', 2016.0, 'Health');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (103, 1, 10, 'Zeta', 'Del 3', 2019.0, 'Rules');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (104, 3, 10, 'Beta', 'Del 4', 2014.0, 'Ways');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (105, 3, 10, 'Beta', 'Del 5', 2015.0, 'Means');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (106, 3, 10, 'Beta', 'Del 6', 2020.0, 'Education');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT county_name FROM (SELECT county_id, county_name, population, zip_code, n, county_id AS district FROM (SELECT LHS.county_id AS county_id, LHS.county_name AS county_name, LHS.population AS population, LHS.zip_code AS zip_code, RHS.n AS n FROM county AS LHS INNER JOIN (SELECT district, COUNT(*) AS n FROM election GROUP BY district) AS RHS ON (LHS.county_id = RHS.district))) WHERE (n >= 2) ORDER BY county_name;

/*
Gold Result:
('Beta',)
('Zeta',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District GROUP BY T1.County_id HAVING COUNT(*) >= 2;

/*
Prediction Result:
('Zeta',)
('Beta',)
*/