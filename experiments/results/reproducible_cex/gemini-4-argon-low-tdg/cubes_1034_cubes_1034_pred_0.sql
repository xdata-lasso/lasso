-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO College (cName, state, enr) VALUES ('Harvard', 'MA', 20000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (10, 'Dave', 'yes', 1500);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (20, 'Eve', 'yes', 1600);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (10, 'Harvard', 'def', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (20, 'Harvard', 'mid', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "decision", COUNT(*) AS "n" FROM "tryout" GROUP BY "decision") WHERE ("decision" = 'yes') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM tryout WHERE decision = 'yes';

/*
Prediction Result:
(0,)
*/