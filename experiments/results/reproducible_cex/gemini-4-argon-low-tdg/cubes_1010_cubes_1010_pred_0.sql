-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Alpha', 'CA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Beta', 'NY', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Gamma', 'TX', 20000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Delta', 'FL', 25000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'P1', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'P2', 'yes', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'P3', 'no', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4, 'P4', 'yes', 1200);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Alpha', 'striker', 'aaa');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Delta', 'goalie', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'Beta', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (4, 'Gamma', 'defense', 'zzz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'goalie' OR "ppos" = 'mid')) ORDER BY decision) LIMIT 1);

/*
Gold Result:
('Delta',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'goalie' INTERSECT SELECT cName FROM tryout WHERE pPos = 'mid';

/*
Prediction Result:
*/