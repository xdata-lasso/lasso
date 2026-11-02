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
INSERT INTO College (cName, state, enr) VALUES ('Cornell', 'NY', 21000);
INSERT INTO College (cName, state, enr) VALUES ('Yale', 'CT', 12000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (101, 'Alex', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (102, 'Blake', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (103, 'Casey', 'no', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (104, 'Drew', 'yes', 600);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (105, 'Evan', 'no', 950);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (106, 'Finley', 'yes', 1100);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (107, 'Gray', NULL, 700);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Stanford', 'defense', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Berkeley', 'keeper', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Stanford', 'striker', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'MIT', 'striker', NULL);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Berkeley', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'Stanford', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (104, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (105, 'Berkeley', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (106, 'MIT', 'goalie', NULL);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'MIT', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'MIT', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'Berkeley', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (104, 'Berkeley', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (105, 'Stanford', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (106, 'Stanford', 'mid', NULL);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (101, 'Cornell', NULL, 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (102, 'Cornell', NULL, 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (103, 'Cornell', NULL, NULL);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (104, 'Cornell', NULL, 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (105, 'Cornell', NULL, 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) OVER () AS "count___" FROM "tryout" WHERE ("ppos" <> 'goalie' AND "ppos" <> 'mid') ORDER BY count___, tryout.pid NULLS LAST, tryout.cname NULLS LAST;

/*
Gold Result:
(4,)
(4,)
(4,)
(4,)
*/

-- Prediction Query
SELECT COUNT(*) FROM (SELECT cName FROM tryout WHERE pPos = 'goalie' INTERSECT SELECT cName FROM tryout WHERE pPos = 'mid');

/*
Prediction Result:
(3,)
*/