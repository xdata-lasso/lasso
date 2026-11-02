-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Christopher Bernard', 'Michigan', 1007.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1008.5, 'James Howard', 'guy', 1009.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1010.5, NULL, NULL, NULL);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1008.5, 'Christopher Bernard', 'PM', 'everything');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1010.5, 'Christopher Bernard', 'PM', 'everything');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT pname FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.state AS state, RHS.enr AS enr FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, RHS.cname AS cname, RHS.ppos AS ppos, RHS.decision AS decision FROM player AS LHS INNER JOIN tryout AS RHS ON (LHS.pid = RHS.pid)) AS LHS INNER JOIN (SELECT MAX(cname) OVER () AS cname, state, enr FROM college) AS RHS ON (LHS.cname = RHS.cname)) ORDER BY pname;

/*
Gold Result:
(None,)
('James Howard',)
*/

-- Prediction Query
SELECT T2.pName FROM tryout AS T1 JOIN player AS T2 ON T1.pID = T2.pID WHERE T1.cName = (SELECT cName FROM college ORDER BY enr DESC, college.cname NULLS LAST LIMIT 1);

/*
Prediction Result:
('James Howard',)
(None,)
*/