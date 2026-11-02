-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Zero 'yes' dataset: Tests the critical semantic difference between grouping then filtering (returns 0 rows when no 'yes' exists) versus `SELECT COUNT(*) FROM Tryout WHERE decision = 'yes'` without GROUP BY (which returns 1 row with value 0).
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 30000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (10, 'Eve', 'yes', 500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (20, 'Frank', 'no', 600);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (10, 'Berkeley', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (20, 'Berkeley', 'def', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "decision", COUNT(*) AS "n" FROM "tryout" GROUP BY "decision") WHERE ("decision" = 'yes') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM tryout WHERE decision = 'yes';

/*
Prediction Result:
(0,)
*/