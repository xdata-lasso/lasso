-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Harvard', 'MA', 20000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 11000);
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 16000);
INSERT INTO College (cName, state, enr) VALUES ('Yale', 'CT', 14000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Zack', 'yes', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Alice', 'no', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Alice', 'yes', 950);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'Bob', 'no', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (5, 'Charlie', 'yes', 1100);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Yale', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Yale', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Harvard', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'Yale', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'Harvard', 'def', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'MIT', 'def', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pname FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.state AS state, RHS.enr AS enr FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, RHS.cname AS cname, RHS.ppos AS ppos, RHS.decision AS decision FROM player AS LHS INNER JOIN tryout AS RHS ON (LHS.pid = RHS.pid)) AS LHS INNER JOIN (SELECT MAX(cname) OVER () AS cname, state, enr FROM college) AS RHS ON (LHS.cname = RHS.cname)) ORDER BY pname;

/*
Gold Result:
('Alice',)
('Zack',)
*/

-- Prediction Query
SELECT T2.pName FROM tryout AS T1 JOIN player AS T2 ON T1.pID = T2.pID WHERE T1.cName = (SELECT cName FROM college ORDER BY enr DESC, college.cname NULLS LAST LIMIT 1);

/*
Prediction Result:
('Alice',)
('Bob',)
*/