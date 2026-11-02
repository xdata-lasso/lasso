-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cName", "state", "enr") VALUES ('A', 'CA', 1000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('B', 'NY', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Bob', 'no', 100);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Alice', 'no', 200);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'B', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'A', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname", "cname" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM "tryout" AS "LHS" INNER JOIN "player" AS "RHS" ON ("LHS"."pid" = "RHS"."pid")) WHERE ("decision" = 'yes') ORDER BY pname, "pname" NULLS LAST, "cname" NULLS LAST;

/*
Gold Result:
('Alice', 'A')
('Bob', 'B')
*/

-- Prediction Query
SELECT T1.pName, T2.cName FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes';

/*
Prediction Result:
('Bob', 'B')
('Alice', 'A')
*/