-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests basic filtering, 'goalie' winning the ORDER BY, and excluding invalid pPos with a lexicographically smaller decision.
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Stanford', 'CA', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Berkeley', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('MIT', 'MA', 10000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Charlie', 'no', 1500);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Stanford', 'striker', 'a');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Berkeley', 'goalie', 'b');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'MIT', 'mid', 'c');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'goalie' OR "ppos" = 'mid')) ORDER BY decision) LIMIT 1);

/*
Gold Result:
('Berkeley',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'goalie' INTERSECT SELECT cName FROM tryout WHERE pPos = 'mid';

/*
Prediction Result:
*/