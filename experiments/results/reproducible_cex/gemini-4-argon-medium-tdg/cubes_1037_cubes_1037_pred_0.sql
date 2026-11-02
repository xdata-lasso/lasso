-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
-- Tests duplicate preservation (SELECT vs SELECT DISTINCT) when one player has multiple 'yes' decisions, and secondary sorting on "hs".
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UCLA', 'CA', 32000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (10, 'Zack', 'no', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (20, 'Aaron', 'yes', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (30, 'Aaron', 'no', 500);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (10, 'Berkeley', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (10, 'UCLA', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (20, 'Berkeley', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (30, 'UCLA', 'goalie', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname", "hs" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM "tryout" AS "LHS" INNER JOIN "player" AS "RHS" ON ("LHS"."pid" = "RHS"."pid")) WHERE ("decision" = 'yes') ORDER BY pname, "pname" NULLS LAST, "hs" NULLS LAST;

/*
Gold Result:
('Aaron', 500.0)
('Aaron', 1500.0)
('Zack', 2000.0)
('Zack', 2000.0)
*/

-- Prediction Query
SELECT T1.pName, T1.HS FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes';

/*
Prediction Result:
('Zack', 2000.0)
('Zack', 2000.0)
('Aaron', 1500.0)
('Aaron', 500.0)
*/