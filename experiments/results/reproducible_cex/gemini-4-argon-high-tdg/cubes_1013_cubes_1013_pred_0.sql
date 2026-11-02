-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('Yale', 'CT', 12000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 900);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Charlie', 'yes', 250);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'Diana', 'no', 600);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (5, 'Evan', 'no', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (6, 'Frank', 'yes', 100);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'MIT', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'Stanford', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'MIT', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'Stanford', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (5, 'MIT', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hs AS min_t2_hs_, ppos FROM (SELECT ppos, MIN(hs) AS hs FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, RHS.cname AS cname, RHS.ppos AS ppos, RHS.decision AS decision FROM player AS LHS INNER JOIN tryout AS RHS ON (LHS.pid = RHS.pid)) GROUP BY ppos) ORDER BY min_t2_hs_, ppos NULLS LAST;

/*
Gold Result:
(250.0, 'mid')
(600.0, 'striker')
(900.0, 'goalie')
*/

-- Prediction Query
SELECT MIN(T2.HS), T1.pPos FROM tryout AS T1 JOIN player AS T2 ON T1.pID = T2.pID GROUP BY T1.pPos;

/*
Prediction Result:
(900.0, 'goalie')
(250.0, 'mid')
(600.0, 'striker')
*/