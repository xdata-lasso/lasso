-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "College" ("cName", "state", "enr") VALUES ('A_Univ', 'CA', 10000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('M_Univ', 'NY', 15000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('Z_Univ', 'TX', 20000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'Alice', 'no', 1000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2, 'Bob', 'yes', 1200);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (3, 'Charlie', 'no', 1100);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'Z_Univ', 'defense', 'no');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2, 'M_Univ', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (3, 'A_Univ', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'mid' OR "ppos" = 'goalie')) ORDER BY cname DESC) LIMIT 1);

/*
Gold Result:
('M_Univ',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'mid' EXCEPT SELECT cName FROM tryout WHERE pPos = 'goalie';

/*
Prediction Result:
('A_Univ',)
*/