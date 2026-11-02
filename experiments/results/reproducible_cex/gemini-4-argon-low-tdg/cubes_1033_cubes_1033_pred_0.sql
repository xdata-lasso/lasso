-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UCLA', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 30000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Dave', 'no', 500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Eve', 'yes', 600);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'UCLA', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Berkeley', 'defense', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT "n" AS "count___" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."enr" AS "enr", "RHS"."n" AS "n" FROM "tryout" AS "LHS" INNER JOIN (SELECT "cname", "enr", COUNT(*) AS "n" FROM "college" GROUP BY "cname", "enr") AS "RHS" ON ("LHS"."cname" = "RHS"."cname")) WHERE ("ppos" = 'mid' OR "ppos" <> 'goalie') ORDER BY count___;

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM (SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'mid' EXCEPT SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'goalie');

/*
Prediction Result:
(0,)
*/