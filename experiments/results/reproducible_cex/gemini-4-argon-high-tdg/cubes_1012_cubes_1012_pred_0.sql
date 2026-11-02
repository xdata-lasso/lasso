-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 10000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Zane', 'yes', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Alice', 'no', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Bob', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'Charlie', NULL, 1000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (5, 'Aaron', 'yes', 2000);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (4, 'MIT', 'forward', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (5, 'Stanford', 'defense', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (5, 'MIT', 'defense', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname" FROM "player" WHERE ("ycard" = 'yes') ORDER BY pname, player.pid NULLS LAST;

/*
Gold Result:
('Aaron',)
('Bob',)
('Zane',)
*/

-- Prediction Query
SELECT pName FROM Player WHERE yCard = 'yes' ORDER BY HS DESC, Player.pid NULLS LAST;

/*
Prediction Result:
('Aaron',)
('Zane',)
('Bob',)
*/