-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cName", "state", "enr") VALUES ('C1', 'NY', 5000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (1, 'P1', 'no', 1000);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (1, 'C1', 'goalie', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(hs) OVER () AS max_t1_hs_, ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.pname AS pname, RHS.ycard AS ycard, RHS.hs AS hs FROM tryout AS LHS INNER JOIN (SELECT * FROM player WHERE (hs >= 1000.0)) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY max_t1_hs_, ppos NULLS LAST;

/*
Gold Result:
(1000.0, 'goalie')
*/

-- Prediction Query
SELECT MAX(T1.HS), pPos FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T1.HS > 1000 GROUP BY T2.pPos;

/*
Prediction Result:
*/