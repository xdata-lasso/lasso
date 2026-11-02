-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (101, 'Alice', 'no', 1000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (102, 'Bob', 'yes', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (103, 'Charlie', 'no', 1100);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Stanford', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'MIT', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Stanford', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'MIT', 'defense', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'Stanford', 'forward', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'MIT', NULL, 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) OVER () AS "count___" FROM "tryout" WHERE ("ppos" <> 'goalie' AND "ppos" <> 'mid') ORDER BY count___, tryout.pid NULLS LAST, tryout.cname NULLS LAST;

/*
Gold Result:
(3,)
(3,)
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM (SELECT cName FROM tryout WHERE pPos = 'goalie' INTERSECT SELECT cName FROM tryout WHERE pPos = 'mid');

/*
Prediction Result:
(0,)
*/