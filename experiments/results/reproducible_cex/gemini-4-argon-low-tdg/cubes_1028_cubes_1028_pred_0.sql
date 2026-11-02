-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 36000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Oxford', NULL, 24000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Harvard', 'MA', 20000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Yale', 'CT', 12000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (101, 'Alice', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (102, 'Bob', 'yes', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (103, 'Charlie', 'no', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (104, 'David', 'yes', 800);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Stanford', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'Stanford', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (103, 'MIT', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Oxford', 'defense', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'Berkeley', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Harvard', 'goalie', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'MIT', 'mid', 'YES');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (103, 'Yale', 'defense', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."state" AS "state", "RHS"."enr" AS "enr" FROM (SELECT * FROM "tryout" WHERE ("decision" = 'yes')) AS LHS INNER JOIN college AS RHS ON (LHS.cname = RHS.cname)) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
(None,)
('CA',)
('CA',)
('CA',)
('MA',)
*/

-- Prediction Query
SELECT DISTINCT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.decision = 'yes';

/*
Prediction Result:
('CA',)
('MA',)
(None,)
*/