-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('Cornell', 'NY', 14000);
INSERT INTO College (cName, state, enr) VALUES ('Rice', 'TX', 7000);
INSERT INTO College (cName, state, enr) VALUES ('Miami', 'FL', 11000);
INSERT INTO College (cName, state, enr) VALUES ('UW', 'WA', 30000);
INSERT INTO College (cName, state, enr) VALUES ('UO', 'OR', 20000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 800);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Rice', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Miami', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'UW', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'UW', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'UO', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'UO', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT * FROM "college" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tryout" WHERE ("ppos" <> 'mid' OR "ppos" = 'goalie')) AS RHS WHERE (LHS.cname = RHS.cname))) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('CA',)
('NY',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'mid' EXCEPT SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'goalie';

/*
Prediction Result:
('CA',)
('OR',)
*/