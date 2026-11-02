-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO party (party_id, year, party, governor, lieutenant_governor, comptroller, attorney_general, us_senate) VALUES (0, 1.0, NULL, 'Democratic', 'Democratic', 'default2', 'default1', 'default1'), (1, 0.0, 'Liberal', 'Democratic', 'Liberal', 'default2', 'Democratic', 'Liberal'), (2, NULL, 'default1', 'Liberal', 'default2', 'default1', 'default2', NULL), (3, NULL, 'default2', 'default2', 'default1', 'Democratic', NULL, 'default2'), (4, NULL, 'Democratic', NULL, NULL, 'Democratic', 'default2', 'default2'), (5, NULL, NULL, 'default2', NULL, NULL, 'Democratic', 'Liberal'), (6, 0.0, 'default2', 'Democratic', 'Liberal', 'Liberal', 'Democratic', 'default1'), (7, NULL, 'default2', 'Democratic', 'default1', 'default1', 'default1', 'default2'), (8, 0.0, NULL, 'default1', NULL, 'Liberal', 'default2', 'Liberal'), (9, 1.0, 'default1', 'Democratic', 'default1', 'Liberal', 'Liberal', 'default2'), (10, NULL, 'default2', 'Liberal', 'Liberal', 'default2', 'Liberal', NULL), (11, NULL, 'Democratic', 'default1', 'Liberal', 'Democratic', 'default2', 'Liberal');
INSERT INTO county (county_id, county_name, population, zip_code) VALUES (0, NULL, NULL, 'Democratic'), (1, 'Liberal', NULL, 'default2'), (2, 'default2', NULL, 'Liberal'), (3, 'default1', 1.0, 'Democratic'), (4, 'default1', NULL, 'default1'), (5, 'default2', NULL, 'default2'), (6, 'default1', NULL, 'default1'), (7, NULL, NULL, 'Democratic'), (8, 'default2', NULL, 'Liberal'), (9, 'default1', NULL, 'default1'), (10, 'default1', 1.0, NULL), (11, 'default2', NULL, 'default1'), (12, 'Democratic', 1.0, 'Liberal'), (13, 'Democratic', NULL, 'default1'), (14, NULL, 1.0, 'Liberal'), (15, NULL, 1.0, NULL), (16, 'Democratic', NULL, 'default2'), (17, 'default1', NULL, 'default2'), (18, 'Democratic', 1.0, 'Democratic');
INSERT INTO election (election_id, district, party, counties_represented, delegate, first_elected, committee) VALUES (0, 0, 11, 'Democratic', NULL, 0.0, 'Liberal'), (1, 17, 1, 'default1', 'Democratic', 0.0, NULL), (2, 0, 9, NULL, NULL, 1.0, 'Democratic'), (3, NULL, 4, 'Liberal', 'Liberal', 1.0, 'default1'), (4, 5, NULL, 'Liberal', 'Liberal', NULL, 'default1'), (5, 5, 6, 'Democratic', 'default2', NULL, 'default1'), (6, 7, 3, NULL, 'default1', NULL, 'default2'), (7, NULL, 3, 'default1', 'default2', NULL, 'Democratic'), (8, 18, 7, 'default2', 'default1', 1.0, 'Liberal'), (9, 17, 8, 'default2', 'Democratic', 1.0, 'default2'), (10, 17, 2, 'Liberal', 'default2', 0.0, 'Democratic');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "committee" FROM (SELECT "election_id", "counties_represented", "district", "delegate", "party", "first_elected", "committee", "party_other", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate", "election_id" AS "party_id" FROM (SELECT "LHS"."election_id" AS "election_id", "LHS"."counties_represented" AS "counties_represented", "LHS"."district" AS "district", "LHS"."delegate" AS "delegate", "LHS"."party" AS "party", "LHS"."first_elected" AS "first_elected", "LHS"."committee" AS "committee", "RHS"."party" AS "party_other", "RHS"."governor" AS "governor", "RHS"."lieutenant_governor" AS "lieutenant_governor", "RHS"."comptroller" AS "comptroller", "RHS"."attorney_general" AS "attorney_general", "RHS"."us_senate" AS "us_senate" FROM "election" AS "LHS" INNER JOIN (SELECT * FROM "party" WHERE ("party" = 'Democratic' OR "party" = 'Liberal')) AS RHS ON (LHS.election_id = RHS.party_id AND LHS.first_elected = RHS.year))) ORDER BY committee, "committee" NULLS LAST;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Democratic' INTERSECT SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Liberal';

/*
Prediction Result:
*/