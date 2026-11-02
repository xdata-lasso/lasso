-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests: Window function MAX(hs) OVER () vs GROUP BY ppos, DISTINCT elimination, ORDER BY ppos ASC vs DESC, and NULLS LAST behavior.
INSERT INTO College (cName, state, enr) VALUES ('C1', 'CA', 5000);
INSERT INTO College (cName, state, enr) VALUES ('C2', 'NY', 6000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 1200.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 1500.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Charlie', 'no', 1800.0);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C1', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C2', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'C1', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'C1', NULL, 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(hs) OVER () AS max_t1_hs_, ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.pname AS pname, RHS.ycard AS ycard, RHS.hs AS hs FROM tryout AS LHS INNER JOIN (SELECT * FROM player WHERE (hs >= 1000.0)) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY max_t1_hs_, ppos NULLS LAST;

/*
Gold Result:
(1800.0, 'goalie')
(1800.0, 'mid')
(1800.0, None)
*/

-- Prediction Query
SELECT MAX(T1.HS), pPos FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T1.HS > 1000 GROUP BY T2.pPos;

/*
Prediction Result:
(1800.0, None)
(1200.0, 'goalie')
(1500.0, 'mid')
*/