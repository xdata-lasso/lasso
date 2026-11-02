-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Benjamin Stanley', 'Wyoming', 1013.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Henry Santiago', 'Vermont', 1016.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1014.5, 'Bobby Hall', 'blood', 1015.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1017.5, 'Maria Lynch', 'Congress', 1018.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1014.5, 'Benjamin Stanley', 'husband', 'fall');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1017.5, 'Henry Santiago', 'none', 'shoulder');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, LHS.n AS n FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.n AS n FROM tryout AS LHS INNER JOIN (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid) AS RHS ON (LHS.pid = RHS.pid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY ppos;

/*
Gold Result:
('husband',)
('none',)
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('husband',)
*/