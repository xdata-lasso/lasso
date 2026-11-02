-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "county" ("County_Id", "County_name", "Population", "Zip_code") VALUES (1, 'A', 100.0, '12345');
INSERT INTO "party" ("Party_ID", "Year", "Party", "Governor", "Lieutenant_Governor", "Comptroller", "Attorney_General", "US_Senate") VALUES (1, 2000.0, 'Democratic', 'G', 'LG', 'C', 'AG', 'USS');
INSERT INTO "election" ("Election_ID", "District", "Party", "Counties_Represented", "Delegate", "First_Elected", "Committee") VALUES (1, 1, 1, 'C1', 'D1', 2000.0, 'Finance');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "committee" FROM (SELECT "election_id", "counties_represented", "district", "delegate", "party", "first_elected", "committee", "party_other", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate", "election_id" AS "party_id" FROM (SELECT "LHS"."election_id" AS "election_id", "LHS"."counties_represented" AS "counties_represented", "LHS"."district" AS "district", "LHS"."delegate" AS "delegate", "LHS"."party" AS "party", "LHS"."first_elected" AS "first_elected", "LHS"."committee" AS "committee", "RHS"."party" AS "party_other", "RHS"."governor" AS "governor", "RHS"."lieutenant_governor" AS "lieutenant_governor", "RHS"."comptroller" AS "comptroller", "RHS"."attorney_general" AS "attorney_general", "RHS"."us_senate" AS "us_senate" FROM "election" AS "LHS" INNER JOIN (SELECT * FROM "party" WHERE ("party" = 'Democratic' OR "party" = 'Liberal')) AS RHS ON (LHS.election_id = RHS.party_id AND LHS.first_elected = RHS.year))) ORDER BY committee, "committee" NULLS LAST;

/*
Gold Result:
('Finance',)
*/

-- Prediction Query
SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Democratic' INTERSECT SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Liberal';

/*
Prediction Result:
*/