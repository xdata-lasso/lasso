-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Alpha', 'CA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('Beta', 'NY', 15000);
INSERT INTO College (cName, state, enr) VALUES ('Gamma', 'TX', 20000);
INSERT INTO College (cName, state, enr) VALUES ('Delta', 'FL', 25000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (101, 'Alex', 'no', 500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (102, 'Bob', 'yes', 600);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (103, 'Charlie', 'no', 700);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (104, 'David', 'yes', 800);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Alpha', 'striker', 'aaa');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Beta', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'Gamma', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (104, 'Delta', 'goalie', 'zzz');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM "tryout" WHERE ("ppos" = 'goalie' OR "ppos" = 'mid')) ORDER BY decision) LIMIT 1);

/*
Gold Result:
('Gamma',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE pPos = 'goalie' INTERSECT SELECT cName FROM tryout WHERE pPos = 'mid';

/*
Prediction Result:
*/