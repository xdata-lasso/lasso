-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('C_NoTryout', 'CA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('C_OnlyMid', 'NY', 12000);
INSERT INTO College (cName, state, enr) VALUES ('C_OnlyGoalie', 'TX', 15000);
INSERT INTO College (cName, state, enr) VALUES ('C_OnlyStriker', 'FL', 20000);
INSERT INTO College (cName, state, enr) VALUES ('C_MidAndGoalie', 'WA', 18000);
INSERT INTO College (cName, state, enr) VALUES ('C_OnlyNullPos', 'OR', 11000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'P1', 'no', 1000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'P2', 'yes', 2000);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C_OnlyMid', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C_OnlyGoalie', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C_OnlyStriker', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C_MidAndGoalie', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'C_MidAndGoalie', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C_OnlyNullPos', NULL, 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT * FROM "college" AS "LHS" WHERE NOT EXISTS(SELECT 1 FROM (SELECT * FROM "tryout" WHERE ("ppos" <> 'mid' OR "ppos" = 'goalie')) AS RHS WHERE (LHS.cname = RHS.cname))) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('CA',)
('NY',)
('OR',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'mid' EXCEPT SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.pPos = 'goalie';

/*
Prediction Result:
('NY',)
*/