-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 11000);
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 17000);
INSERT INTO College (cName, state, enr) VALUES ('UCLA', 'CA', 31000);
INSERT INTO College (cName, state, enr) VALUES ('USC', 'CA', 21000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (5, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (10, 'Bob', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (20, 'Cara', 'no', 2500);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (10, 'UCLA', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (10, 'USC', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (10, 'MIT', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (20, 'UCLA', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (20, 'USC', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (5, 'MIT', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (5, 'Stanford', 'defense', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, LHS.n AS n FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.n AS n FROM tryout AS LHS INNER JOIN (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid) AS RHS ON (LHS.pid = RHS.pid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY ppos;

/*
Gold Result:
('goalie',)
('striker',)
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('mid',)
*/