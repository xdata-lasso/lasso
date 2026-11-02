-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "College" ("cname", "state", "enr") VALUES ('12', '15', 15);
INSERT INTO "College" ("cname", "state", "enr") VALUES ('11', '15', 15);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (13, '15', '15', 15);
INSERT INTO "Player" ("pid", "pname", "ycard", "hs") VALUES (15, '15', '15', 15);
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (15, '12', '18', '15');
INSERT INTO "Tryout" ("pid", "cname", "ppos", "decision") VALUES (15, '11', NULL, '15');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.ppos AS ppos, LHS.n AS n, RHS.pid AS pid_other, RHS.ppos AS ppos_other, RHS.n AS n_other FROM (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS LHS CROSS JOIN (SELECT pid, ppos, COUNT(*) AS n FROM tryout GROUP BY pid, ppos) AS RHS) WHERE (n > n_other) ORDER BY ppos;

/*
Gold Result:
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('18',)
*/