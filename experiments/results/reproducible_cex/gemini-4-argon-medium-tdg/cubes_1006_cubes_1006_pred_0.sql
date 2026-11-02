-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 30000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Zoe', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Alice', 'yes', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Bob', 'no', 800);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4, 'Charlie', 'yes', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (5, 'David', 'no', 900);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Berkeley', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'Stanford', 'striker', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (4, 'Stanford', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (5, 'Berkeley', 'midfield', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."pname" AS "pname", "LHS"."ycard" AS "ycard", "LHS"."hs" AS "hs", "RHS"."cname" AS "cname", "RHS"."ppos" AS "ppos", "RHS"."decision" AS "decision" FROM "player" AS "LHS" INNER JOIN (SELECT * FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'striker')) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY pname, "pname" NULLS LAST;

/*
Gold Result:
('Alice',)
('Zoe',)
*/

-- Prediction Query
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes' AND T2.pPos = 'striker';

/*
Prediction Result:
('Zoe',)
('Alice',)
*/