-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 36000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 11000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Harvard', 'MA', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'P1', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'P2', 'yes', 1100);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'P3', 'no', 1200);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Stanford', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'Stanford', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Berkeley', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'MIT', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'MIT', 'back', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Harvard', 'goalie', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."state" AS "state", "RHS"."enr" AS "enr" FROM (SELECT * FROM "tryout" WHERE ("decision" = 'yes')) AS LHS INNER JOIN college AS RHS ON (LHS.cname = RHS.cname)) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('CA',)
('CA',)
('CA',)
('CA',)
('MA',)
('MA',)
*/

-- Prediction Query
SELECT DISTINCT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.decision = 'yes';

/*
Prediction Result:
('CA',)
('MA',)
*/