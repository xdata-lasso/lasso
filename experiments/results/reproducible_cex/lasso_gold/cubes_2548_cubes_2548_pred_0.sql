-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1126, 'Taylor Heath', 1127.5, '09788');
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1132, 'Jeff Owens', 1128.5, '32351');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1128, 1129.5, 'my', 'economy', 'family', 'relationship', 'mention', 'difficult');
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1134, 1135.5, 'still', 'material', 'surface', 'investment', 'customer', 'between');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1130, 1126, 1128, 'notice', 'cause', 1131.5, 'Appropriations');
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1136, 1132, 1134, 'bill', 'reason', 1137.5, 'Appropriations');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "county_name" FROM (SELECT "LHS"."county_id" AS "county_id", "LHS"."county_name" AS "county_name", "LHS"."population" AS "population", "LHS"."zip_code" AS "zip_code", "RHS"."election_id" AS "election_id", "RHS"."counties_represented" AS "counties_represented", "RHS"."delegate" AS "delegate", "RHS"."party" AS "party", "RHS"."first_elected" AS "first_elected", "RHS"."committee" AS "committee" FROM "county" AS "LHS" INNER JOIN (SELECT * FROM "election" WHERE ("committee" = 'Appropriations')) AS RHS ON (LHS.county_id = RHS.district)) ORDER BY county_name, "county_name" NULLS LAST;

/*
Gold Result:
('Jeff Owens',)
('Taylor Heath',)
*/

-- Prediction Query
SELECT T1.County_name FROM county AS T1 JOIN election AS T2 ON T1.County_id = T2.District WHERE T2.Committee = 'Appropriations';

/*
Prediction Result:
('Taylor Heath',)
('Jeff Owens',)
*/