-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO College (cName, state, enr) VALUES ('C1', 'CA', 5000);
INSERT INTO College (cName, state, enr) VALUES ('C2', 'CA', 3000);
INSERT INTO College (cName, state, enr) VALUES ('C3', 'TX', 4000);
INSERT INTO College (cName, state, enr) VALUES ('C4', NULL, 2000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (1, 'P1', 'no', 1000);
INSERT INTO Player (pID, pName, yCard, HS) VALUES (2, 'P2', 'yes', 1200);
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (1, 'C1', 'goalie', 'yes');
INSERT INTO Tryout (pID, cName, pPos, decision) VALUES (2, 'C1', 'mid', 'no');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT n_distinct AS count_distinct_state_ FROM (SELECT cname, COUNT(DISTINCT state) AS n_distinct FROM (SELECT cname, state, enr, AVG(enr) OVER () AS meanenr FROM college) GROUP BY cname) ORDER BY count_distinct_state_;

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT state) FROM college WHERE enr < (SELECT AVG(enr) FROM college);

/*
Prediction Result:
(1,)
*/