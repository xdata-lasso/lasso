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
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Yale', 'CT', 12000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Harvard', 'MA', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 1200);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Stanford', 'striker', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Berkeley', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'MIT', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'MIT', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Harvard', 'striker', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT * FROM "college" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tryout" WHERE ("ppos" <> 'striker')) AS RHS WHERE (LHS.cname = RHS.cname))) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('CA',)
('CT',)
('MA',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'striker';

/*
Prediction Result:
('CA',)
('CA',)
('MA',)
('MA',)
*/