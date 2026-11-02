-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 36000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Cornell', 'NY', 21000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (101, 'Zack', 'no', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (102, 'Alice', 'yes', 800);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (103, 'Bob', 'yes', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (104, 'Alice', 'no', 600);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (105, 'Dave', 'yes', 900);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Stanford', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (101, 'Berkeley', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (102, 'MIT', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (103, 'Stanford', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (104, 'Cornell', 'defense', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname", "hs" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM "tryout" AS "LHS" INNER JOIN "player" AS "RHS" ON ("LHS"."pid" = "RHS"."pid")) WHERE ("decision" = 'yes') ORDER BY pname, "pname" NULLS LAST, "hs" NULLS LAST;

/*
Gold Result:
('Alice', 600.0)
('Alice', 800.0)
('Zack', 1200.0)
('Zack', 1200.0)
*/

-- Prediction Query
SELECT T1.pName, T1.HS FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes';

/*
Prediction Result:
('Zack', 1200.0)
('Zack', 1200.0)
('Alice', 800.0)
('Alice', 600.0)
*/