-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 11000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Yale', 'CT', 12000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Cornell', 'NY', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Zack', 'yes', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Alice', 'no', 800);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Bob', 'yes', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4, 'Cara', 'no', 900);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (5, 'Dan', 'yes', 1100);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Yale', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'MIT', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Stanford', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'Stanford', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (4, 'MIT', 'defense', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname", "cname" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM "tryout" AS "LHS" INNER JOIN "player" AS "RHS" ON ("LHS"."pid" = "RHS"."pid")) WHERE ("decision" = 'yes') ORDER BY pname, "pname" NULLS LAST, "cname" NULLS LAST;

/*
Gold Result:
('Alice', 'Stanford')
('Zack', 'MIT')
('Zack', 'Yale')
*/

-- Prediction Query
SELECT T1.pName, T2.cName FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes';

/*
Prediction Result:
('Zack', 'Yale')
('Zack', 'MIT')
('Alice', 'Stanford')
*/