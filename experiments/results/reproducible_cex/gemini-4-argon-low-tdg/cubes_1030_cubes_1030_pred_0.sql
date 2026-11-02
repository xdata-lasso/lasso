-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
-- Tests improper joins with Tryout/College ( inner join eliminating players with no tryouts, or join multiplying rows for multiple tryouts) and filtering on yCard
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Zack', 'yes', 800.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Yara', 'no', 900.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Xander', NULL, 1100.0);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'MIT', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT pname, hs FROM player WHERE (hs < 1500.0) ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Xander', 1100.0)
('Yara', 900.0)
('Zack', 800.0)
*/

-- Prediction Query
SELECT pName, HS FROM Player WHERE HS < 1500;

/*
Prediction Result:
('Zack', 800.0)
('Yara', 900.0)
('Xander', 1100.0)
*/