-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('Berkeley', 'CA', 36000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 1000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Charlie', 'no', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'David', 'no', 1500);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'Berkeley', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'MIT', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'MIT', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Berkeley', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'goalie') ORDER BY cname, tryout.pid NULLS LAST;

/*
Gold Result:
('Berkeley',)
('Stanford',)
('Stanford',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE decision = 'yes' AND pPos = 'goalie';

/*
Prediction Result:
('Stanford',)
('Stanford',)
('Berkeley',)
*/