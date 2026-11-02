-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic anti-join behavior:
-- 1. College with NO tryouts (should be included)
-- 2. College with ONLY 'mid' tryout (should be included)
-- 3. College with ONLY 'goalie' tryout (should be excluded)
-- 4. College with ONLY 'striker' tryout (should be excluded: tests "pPos <> 'mid'" vs "pPos = 'goalie'")
-- 5. College with BOTH 'mid' and 'goalie' tryouts (should be excluded: tests existential vs universal quantification)
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C_NoTryout', 'CA', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C_OnlyMid', 'NY', 2000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C_OnlyGoalie', 'TX', 3000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C_OnlyStriker', 'FL', 4000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C_Mixed', 'WA', 5000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 100);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 200);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'C_OnlyMid', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'C_OnlyGoalie', 'goalie', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'C_OnlyStriker', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'C_Mixed', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'C_Mixed', 'goalie', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT * FROM "college" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tryout" WHERE ("ppos" <> 'mid' OR "ppos" = 'goalie')) AS RHS WHERE (LHS.cname = RHS.cname))) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('CA',)
('NY',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'mid' EXCEPT SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'goalie';

/*
Prediction Result:
('NY',)
*/