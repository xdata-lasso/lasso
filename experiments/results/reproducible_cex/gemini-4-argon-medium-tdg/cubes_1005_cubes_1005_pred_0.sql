-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Alpha', 'CA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Beta', 'TX', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Gamma', 'NY', 20000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Zeta', 'FL', 25000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'John', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 1500);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Alice', 'no', 2000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (4, 'Eve', 'yes', 2500);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Alpha', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'Beta', 'goalie', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'Gamma', 'mid', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (4, 'Zeta', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'mid' OR "ppos" = 'goalie')) ORDER BY cname DESC) LIMIT 1);

/*
Gold Result:
('Gamma',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'mid' EXCEPT SELECT cName FROM tryout WHERE pPos = 'goalie';

/*
Prediction Result:
('Alpha',)
('Gamma',)
*/