-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'Zulu', 100.0, '12345');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (2, 'Alpha', 200.0, '67890');
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (3, NULL, 300.0, '11111');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, NULL, '1', 'Del1', 2000.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (2, 2, NULL, '2', 'Del2', 2000.0, 'Appropriations');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (3, 3, NULL, '3', 'Del3', 2000.0, 'Appropriations');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "county_name" FROM (SELECT "LHS"."county_id" AS "county_id", "LHS"."county_name" AS "county_name", "LHS"."population" AS "population", "LHS"."zip_code" AS "zip_code", "RHS"."election_id" AS "election_id", "RHS"."counties_represented" AS "counties_represented", "RHS"."delegate" AS "delegate", "RHS"."party" AS "party", "RHS"."first_elected" AS "first_elected", "RHS"."committee" AS "committee" FROM "county" AS "LHS" INNER JOIN (SELECT * FROM "election" WHERE ("committee" = 'Appropriations')) AS RHS ON (LHS.county_id = RHS.district)) ORDER BY county_name, "county_name" NULLS LAST;

/*
Gold Result:
(None,)
('Alpha',)
('Zulu',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T2.Committee = 'Appropriations';

/*
Prediction Result:
('Zulu',)
('Alpha',)
(None,)
*/