-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('ASU', 'AZ', 12000);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 5000);
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 8000);
INSERT INTO College (cName, state, enr) VALUES ('UCLA', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('Yale', 'CT', 6000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Charlie', NULL, 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (4, 'Diana', 'no', 900);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'ASU', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'ASU', 'goalie', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'ASU', NULL, NULL);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'UCLA', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'UCLA', 'mid', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'MIT', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'MIT', NULL, 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'goalie', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___, cname FROM (SELECT cname, COUNT(*) AS n FROM tryout GROUP BY cname) ORDER BY count___, cname NULLS LAST;

/*
Gold Result:
(1, 'Stanford')
(2, 'MIT')
(2, 'UCLA')
(3, 'ASU')
*/

-- Prediction Query
SELECT COUNT(*), cName FROM tryout GROUP BY cName ORDER BY COUNT(*) DESC, cName NULLS LAST;

/*
Prediction Result:
(3, 'ASU')
(2, 'MIT')
(2, 'UCLA')
(1, 'Stanford')
*/