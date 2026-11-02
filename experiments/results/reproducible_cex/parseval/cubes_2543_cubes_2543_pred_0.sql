-- Schema DDL
CREATE TABLE "county" ("County_Id" INTEGER PRIMARY KEY, "County_name" TEXT, "Population" REAL, "Zip_code" TEXT);

CREATE TABLE "party" ("Party_ID" INTEGER PRIMARY KEY, "Year" REAL, "Party" TEXT, "Governor" TEXT, "Lieutenant_Governor" TEXT, "Comptroller" TEXT, "Attorney_General" TEXT, "US_Senate" TEXT);

CREATE TABLE "election" ("Election_ID" INTEGER PRIMARY KEY, "District" INTEGER, "Party" INTEGER, "Counties_Represented" TEXT, "Delegate" TEXT, "First_Elected" REAL, "Committee" TEXT, FOREIGN KEY ("District") REFERENCES "county" ("County_Id"), FOREIGN KEY ("Party") REFERENCES "party" ("Party_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: county --
INSERT INTO "county" ("county_id", "county_name", "population", "zip_code") VALUES (1, '5k5swwqcgs', 171.746906, 'n8c4pgu7v');

-- Inserting into table: party --
INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (1, 1.0, 'Liberal', 'par_b06813', 'par_6ee2e8', 'par_55b926', 'par_d22a54', 'par_39a058');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (-2147483647, 1.0, 'Liberal', 'par_f9b8ba', 'par_a418d8', 'par_668576', 'par_f911d2', 'par_80b020');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (5, 906.21648, 'Liberal', 'hria2ypu', 'hsrwbbp', 'luhvdltti', 'bnp', 'mdpos');

INSERT INTO "party" ("party_id", "year", "party", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate") VALUES (3, 133.007885, 'Liberal', '5u', 'w6kl', 'a9', '00t5c4e', 'cigce376nium');

-- Inserting into table: election --
INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (1, 1, 1, 'lhs_697487', 'lhs_0364cf', 1.0, 'lhs_2ae221');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (-2147483647, 1, 1, 'lhs_c63677', 'lhs_ca765b', 1.0, 'lhs_979242');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (-2147483646, 1, 3, 'zbuo4nrqrof', 'qyp5s5bbp0', 673.065986, 'q_1_c8d3cc');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (-2147483645, 1, 5, 'liqa1', 'ryytoo3', 228.583847, 'q_1_c8d3cc');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (2, 1, -2147483647, '72klex14ji7z', 'au2dwy', 278.010437, '3pyu78d');

INSERT INTO "election" ("election_id", "district", "party", "counties_represented", "delegate", "first_elected", "committee") VALUES (4, 1, -2147483647, 'sl0', '4', 884.000446, 'p5qi2rkf9v');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "committee" FROM (SELECT "election_id", "counties_represented", "district", "delegate", "party", "first_elected", "committee", "party_other", "governor", "lieutenant_governor", "comptroller", "attorney_general", "us_senate", "election_id" AS "party_id" FROM (SELECT "LHS"."election_id" AS "election_id", "LHS"."counties_represented" AS "counties_represented", "LHS"."district" AS "district", "LHS"."delegate" AS "delegate", "LHS"."party" AS "party", "LHS"."first_elected" AS "first_elected", "LHS"."committee" AS "committee", "RHS"."party" AS "party_other", "RHS"."governor" AS "governor", "RHS"."lieutenant_governor" AS "lieutenant_governor", "RHS"."comptroller" AS "comptroller", "RHS"."attorney_general" AS "attorney_general", "RHS"."us_senate" AS "us_senate" FROM "election" AS "LHS" INNER JOIN (SELECT * FROM "party" WHERE ("party" = 'Democratic' OR "party" = 'Liberal')) AS RHS ON (LHS.election_id = RHS.party_id AND LHS.first_elected = RHS.year))) ORDER BY committee, "committee" NULLS LAST;

/*
Gold Result:
('lhs_2ae221',)
('lhs_979242',)
*/

-- Prediction Query
SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Democratic' INTERSECT SELECT T1.Committee FROM election AS T1 JOIN party AS T2 ON T1.Party = T2.Party_ID WHERE T2.Party = 'Liberal';

/*
Prediction Result:
*/