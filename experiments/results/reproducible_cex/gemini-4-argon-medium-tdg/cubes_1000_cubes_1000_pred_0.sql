-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000.0);
INSERT INTO College (cName, state, enr) VALUES ('MIT', 'MA', 14999.9);
INSERT INTO College (cName, state, enr) VALUES ('Harvard', 'MA', 20000.0);
INSERT INTO College (cName, state, enr) VALUES ('Yale', 'CT', NULL);
INSERT INTO College (cName, state, enr) VALUES ('Princeton', NULL, 25000.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 1000.0);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 2000.0);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Stanford', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'Stanford', 'striker', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT n AS count___ FROM (SELECT COUNT(*) AS n FROM (SELECT * FROM college WHERE (enr >= 15000.0))) ORDER BY count___;

/*
Gold Result:
(3,)
*/

-- Prediction Query
SELECT COUNT(*) FROM College WHERE enr > 15000;

/*
Prediction Result:
(2,)
*/