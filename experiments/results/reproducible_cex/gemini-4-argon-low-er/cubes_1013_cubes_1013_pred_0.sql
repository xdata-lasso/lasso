-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C1', 'CA', 1000.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1.0, 'P1', 'no', 200.0);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (2.0, 'P2', 'no', 100.0);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1.0, 'C1', 'A', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (2.0, 'C1', 'B', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hs AS min_t2_hs_, ppos FROM (SELECT ppos, MIN(hs) AS hs FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, RHS.cname AS cname, RHS.ppos AS ppos, RHS.decision AS decision FROM player AS LHS INNER JOIN tryout AS RHS ON (LHS.pid = RHS.pid)) GROUP BY ppos) ORDER BY min_t2_hs_, ppos NULLS LAST;

/*
Gold Result:
(100.0, 'B')
(200.0, 'A')
*/

-- Prediction Query
SELECT MIN(T2.HS), T1.pPos FROM tryout AS T1 JOIN player AS T2 ON T1.pID = T2.pID GROUP BY T1.pPos;

/*
Prediction Result:
(200.0, 'A')
(100.0, 'B')
*/