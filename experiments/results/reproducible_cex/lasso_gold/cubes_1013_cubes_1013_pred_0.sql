-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Kevin Pacheco', 'Alabama', 1008.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Gabrielle Davis', 'Connecticut', 1011.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1009.5, 'Caitlin Henderson', 'fall', 1010.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1012.5, 'Gregory Baker', 'animal', NULL);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1009.5, 'Kevin Pacheco', 'clearly', 'dinner');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1012.5, 'Gabrielle Davis', 'show', 'machine');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT hs AS min_t2_hs_, ppos FROM (SELECT ppos, MIN(hs) AS hs FROM (SELECT LHS.pid AS pid, LHS.pname AS pname, LHS.ycard AS ycard, LHS.hs AS hs, RHS.cname AS cname, RHS.ppos AS ppos, RHS.decision AS decision FROM player AS LHS INNER JOIN tryout AS RHS ON (LHS.pid = RHS.pid)) GROUP BY ppos) ORDER BY min_t2_hs_, ppos NULLS LAST;

/*
Gold Result:
(None, 'show')
(1010.5, 'clearly')
*/

-- Prediction Query
SELECT MIN(T2.HS), T1.pPos FROM tryout AS T1 JOIN player AS T2 ON T1.pID = T2.pID GROUP BY T1.pPos;

/*
Prediction Result:
(1010.5, 'clearly')
(None, 'show')
*/