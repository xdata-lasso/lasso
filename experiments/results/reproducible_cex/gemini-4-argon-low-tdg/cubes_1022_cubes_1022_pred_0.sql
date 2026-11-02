-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('C1', 'CA', 1000);
INSERT INTO College (cName, state, enr) VALUES ('C2', 'NY', 2000);
INSERT INTO College (cName, state, enr) VALUES ('C3', 'TX', 3000);
INSERT INTO College (cName, state, enr) VALUES ('C4', 'FL', 4000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 600);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Charlie', 'no', 700);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'David', 'yes', 800);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C1', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C2', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C3', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'C1', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'C2', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'C1', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'C2', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'C3', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'C4', 'def', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.ppos AS ppos, LHS.n AS n, RHS.pid AS pid_other, RHS.ppos AS ppos_other, RHS.n AS n_other FROM (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS LHS CROSS JOIN (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS RHS) WHERE (n > n_other) ORDER BY ppos;

/*
Gold Result:
('goalie',)
('striker',)
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('striker',)
*/