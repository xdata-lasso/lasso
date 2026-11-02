-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO College (cName, state, enr) VALUES ('Auburn', 'AL', 28000);
INSERT INTO College (cName, state, enr) VALUES ('Baylor', 'TX', 18000);
INSERT INTO College (cName, state, enr) VALUES ('Clemson', 'SC', 24000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Evan', 'no', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Frank', 'yes', 900);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Grace', 'no', 1100);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'Hank', 'yes', 1200);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Auburn', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Auburn', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Baylor', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'Baylor', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'Clemson', 'defense', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'mid' OR "ppos" = 'goalie')) ORDER BY cname DESC) LIMIT 1);

/*
Gold Result:
('Baylor',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'mid' EXCEPT SELECT cName FROM tryout WHERE pPos = 'goalie';

/*
Prediction Result:
*/