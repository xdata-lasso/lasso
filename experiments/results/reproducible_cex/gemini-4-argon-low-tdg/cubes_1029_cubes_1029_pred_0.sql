-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests ties for maximum enrollment across both 'FL' and non-'FL' states, Ordering (ASC vs DESC), and LIMIT 1 mutants.
-- Also tests mutants that improperly join with Tryout (since 'ASU' has no Tryout rows).
-- Expected output: 'ASU', 'OSU' (in that order).
INSERT INTO "College" ("cName", "state", "enr") VALUES ('OSU', 'OH', 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('ASU', 'AZ', 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UCF', 'FL', 60000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 11000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Caltech', 'CA', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alex', 'no', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Sam', 'yes', 1500);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'OSU', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'OSU', 'goalie', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT "cname", "state", "enr", MAX("enr") OVER () AS "maxenr" FROM "college") WHERE ("state" <> 'FL' AND maxenr = enr) ORDER BY cname, "cname" NULLS LAST;

/*
Gold Result:
('ASU',)
('OSU',)
*/

-- Prediction Query
SELECT cName FROM college WHERE enr > (SELECT MAX(enr) FROM college WHERE state = 'FL');

/*
Prediction Result:
*/