-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('UF', 'FL', 50000);
INSERT INTO College (cName, state, enr) VALUES ('Miami', 'FL', 30000);
INSERT INTO College (cName, state, enr) VALUES ('FSU', 'FL', 40000);
INSERT INTO College (cName, state, enr) VALUES ('UCF', 'FL', 30000);
INSERT INTO College (cName, state, enr) VALUES ('Stanford', 'CA', 15000);
INSERT INTO College (cName, state, enr) VALUES ('USC', 'CA', 30000);
INSERT INTO College (cName, state, enr) VALUES ('UT', 'TX', 50000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'Alice', 'no', 1200);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'Bob', 'yes', 800);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (3, 'Charlie', 'no', 1500);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'UF', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'UF', 'mid', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'Miami', 'striker', 'no');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (3, 'Stanford', 'goalie', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "enr" AS "avg_enr_" FROM "college" WHERE ("state" = 'FL') ORDER BY avg_enr_, college.cname NULLS LAST;

/*
Gold Result:
(30000.0,)
(30000.0,)
(40000.0,)
(50000.0,)
*/

-- Prediction Query
SELECT AVG(enr) FROM College WHERE state = 'FL';

/*
Prediction Result:
(37500.0,)
*/