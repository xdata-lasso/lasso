-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO College (cName, state, enr) VALUES ('Berkeley', 'CA', 36000);
INSERT INTO College (cName, state, enr) VALUES ('Duke', 'NC', 16000);
INSERT INTO College (cName, state, enr) VALUES ('Auburn', 'AL', 25000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (100, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (200, 'Bob', 'no', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (300, 'Charlie', 'yes', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (400, 'David', 'no', 900);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (500, 'Eve', 'yes', 1100);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (100, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (200, 'MIT', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (400, 'MIT', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (500, 'Berkeley', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (300, 'Duke', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (300, 'Auburn', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (400, 'Duke', 'midfield', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "cname" FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'goalie') ORDER BY cname, tryout.pid NULLS LAST;

/*
Gold Result:
('Berkeley',)
('MIT',)
('MIT',)
('Stanford',)
*/

-- Prediction Query
SELECT cName FROM tryout WHERE decision = 'yes' AND pPos = 'goalie';

/*
Prediction Result:
('Stanford',)
('MIT',)
('MIT',)
('Berkeley',)
*/