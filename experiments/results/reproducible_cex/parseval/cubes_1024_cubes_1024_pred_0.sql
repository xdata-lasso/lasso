-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('lhs_2fed67', 'e4', 1.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_a4b31e', 'pla_f3f4ed', 1000.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'lhs_2fed67', 'lhs_470f64', 'lhs_5a39d1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT MAX(hs) OVER () AS max_t1_hs_, ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.pname AS pname, RHS.ycard AS ycard, RHS.hs AS hs FROM tryout AS LHS INNER JOIN (SELECT * FROM player WHERE (hs >= 1000.0)) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY max_t1_hs_, ppos NULLS LAST;

/*
Gold Result:
(1000.0, 'lhs_470f64')
*/

-- Prediction Query
SELECT MAX(T1.HS), pPos FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T1.HS > 1000 GROUP BY T2.pPos;

/*
Prediction Result:
*/