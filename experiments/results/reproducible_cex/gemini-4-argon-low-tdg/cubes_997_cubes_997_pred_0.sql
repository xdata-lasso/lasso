-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic join, WHERE filter (pName = 'Charles' vs others), ORDER BY ASC, NULLS LAST, and inner join filtering (unmatched rows in College and Player).
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('NullStateU', NULL, 5000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UnmatchedCollege', 'TX', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Charles', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'David', 'yes', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Charles', 'yes', 800);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4, NULL, 'no', 900);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'MIT', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'striker', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'NullStateU', 'mid', NULL);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'MIT', 'def', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (4, 'Stanford', 'goalie', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT "LHS"."cname" AS "cname", "LHS"."state" AS "state", "LHS"."enr" AS "enr", "LHS"."pid" AS "pid", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM (SELECT "LHS"."cname" AS "cname", "LHS"."state" AS "state", "LHS"."enr" AS "enr", "RHS"."pid" AS "pid", "RHS"."ppos" AS "ppos", "RHS"."decision" AS "decision" FROM "college" AS "LHS" INNER JOIN "tryout" AS "RHS" ON ("LHS"."cname" = "RHS"."cname")) AS "LHS" INNER JOIN (SELECT * FROM "player" WHERE ("pname" = 'Charles')) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
(None,)
('CA',)
('MA',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName JOIN player AS T3 ON T2.pID = T3.pID WHERE T3.pName = 'Charles';

/*
Prediction Result:
('MA',)
(None,)
('CA',)
*/