-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483648, '5k5swwqcgs', 1.0, 171.746906, 'n8c4pgu7v');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (1, 'rhs_7fb0e6', 1.0, 1.0, 'rhs_c02405');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483646, 'e4', 1.0, 779.409124, 'hria2ypuzhs');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483645, 'rwbbp6luhvd', 1.0, 179.378884, 'ilbnp');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483644, 'mdpos', 133.007885, 75.403642, NULL);

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483643, 'nw6klf', 1.0, 741.842896, NULL);

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483642, '9000t5c4ec', 1.0, 128.76421, NULL);

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483641, NULL, 610.208018, 108.098664, 'e376nium52');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483640, NULL, 1.0, 816.814398, 'buo4nrq');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483639, NULL, 1.0, 597.420508, 'fqyp');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483638, 's5bbp02e', 325.080047, NULL, 'iqa');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483637, '1ryytoo', 1.0, NULL, 'o9hl72kl');

INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483636, 'x1', 1.0, NULL, 'ji7zwau2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT weight FROM (SELECT LHS.height AS height, RHS.people_id AS people_id, RHS.name AS name, RHS.weight AS weight, RHS.date_of_birth AS date_of_birth FROM (SELECT MIN(height) AS height FROM people) AS LHS LEFT JOIN people AS RHS ON (LHS.height = RHS.height)) ORDER BY weight;

/*
Gold Result:
(None,)
(None,)
(1.0,)
(128.76421,)
(171.746906,)
(179.378884,)
(597.420508,)
(741.842896,)
(779.409124,)
(816.814398,)
*/

-- Prediction Query
SELECT Weight FROM people ORDER BY Height ASC, people.people_id NULLS LAST LIMIT 1;

/*
Prediction Result:
(171.746906,)
*/