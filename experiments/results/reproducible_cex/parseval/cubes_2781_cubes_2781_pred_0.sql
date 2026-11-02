-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: people --
INSERT INTO "people" ("people_id", "name", "height", "weight", "date_of_birth") VALUES (-2147483648, '5k5swwqcgs', 171.746906, 557.512061, '8c4pgu7vfe');

-- Inserting into table: entrepreneur --
INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (2, -2147483648, 'ent_4a72b8', 483.665643, 'hria2ypuzhs');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (3, -2147483648, 'ent_4a72b8', 711.020062, 'b');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (4, -2147483648, 'luhvdltti', 182.319045, 'nprmdposii');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (5, -2147483648, 'unw6klfa', 587.783596, '000t5c4ec');

INSERT INTO "entrepreneur" ("entrepreneur_id", "people_id", "company", "money_requested", "investor") VALUES (6, -2147483648, 'gce376nium52', 816.814398, 'buo4nrq');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT COUNT(*) OVER () AS count_distinct_company_ FROM entrepreneur ORDER BY count_distinct_company_;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT Company) FROM entrepreneur;

/*
Prediction Result:
(4,)
*/