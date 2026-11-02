-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Zeta County', 50000.0, '10001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Alpha County', 75000.0, '10002');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Beta County', 60000.0, '10003');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, NULL, 30000.0, '10004');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (5, 'Unmatched County', 20000.0, '10005');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (10, 2020.0, 'Democratic', 'Gov A', 'LtGov A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (101, 1, 10, 'Rep Zeta', 'Del 1', 2018.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (102, 2, 10, 'Rep Alpha 1', 'Del 2', 2016.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (103, 2, NULL, 'Rep Alpha 2', 'Del 3', 2020.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (104, 3, 10, 'Rep Beta', 'Del 4', 2014.0, 'Judiciary');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (105, 4, 10, 'Rep NullCounty', 'Del 5', 2019.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (106, NULL, 10, 'Rep NoDistrict', 'Del 6', 2021.0, 'Appropriations');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "county_name" FROM (SELECT "LHS"."county_id" AS "county_id", "LHS"."county_name" AS "county_name", "LHS"."population" AS "population", "LHS"."zip_code" AS "zip_code", "RHS"."election_id" AS "election_id", "RHS"."counties_represented" AS "counties_represented", "RHS"."delegate" AS "delegate", "RHS"."party" AS "party", "RHS"."first_elected" AS "first_elected", "RHS"."committee" AS "committee" FROM "county" AS "LHS" INNER JOIN (SELECT * FROM "election" WHERE ("committee" = 'Appropriations')) AS RHS ON (LHS.county_id = RHS.district)) ORDER BY county_name, "county_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha County',)
('Alpha County',)
('Zeta County',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T2.Committee = 'Appropriations';

/*
Prediction Result:
('Zeta County',)
('Alpha County',)
('Alpha County',)
(None,)
*/