-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Zeta County', 50000.0, '21001');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Alpha County', 90000.0, '21002');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, 'Beta County', 10000.0, '21003');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (4, 'Gamma County', 75000.0, '21004');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (5, 'Delta County', 30000.0, '21005');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2020.0, 'Democratic', 'Gov A', 'Lt A', 'Comp A', 'AG A', 'Sen A');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (2, 2022.0, 'Republican', 'Gov B', 'Lt B', 'Comp B', 'AG B', 'Sen B');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 3, 1, 'Zeta County', 'Delegate One', 2014.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 1, 2, 'Alpha County', 'Delegate Two', 2018.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (3, 2, 1, 'Beta County', 'Delegate Three', 2010.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (4, 4, 2, 'Gamma County', 'Delegate Four', 2016.0, 'Ways and Means');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (5, 4, 1, 'Gamma County', 'Delegate Five', 2020.0, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "county_name" FROM (SELECT "LHS"."county_id" AS "county_id", "LHS"."county_name" AS "county_name", "LHS"."population" AS "population", "LHS"."zip_code" AS "zip_code", "RHS"."election_id" AS "election_id", "RHS"."counties_represented" AS "counties_represented", "RHS"."delegate" AS "delegate", "RHS"."party" AS "party", "RHS"."first_elected" AS "first_elected", "RHS"."committee" AS "committee" FROM "county" AS "LHS" INNER JOIN (SELECT * FROM "election" WHERE ("committee" = 'Appropriations')) AS RHS ON (LHS.county_id = RHS.district)) ORDER BY county_name, "county_name" NULLS LAST;

/*
Gold Result:
('Alpha County',)
('Beta County',)
('Zeta County',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T2.Committee = 'Appropriations';

/*
Prediction Result:
('Beta County',)
('Zeta County',)
('Alpha County',)
*/