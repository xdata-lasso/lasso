-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Michael Miles', 'Utah', 1022.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('James Mayo', 'Utah', 1022.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1023.5, 'Lisa Jackson', 'shoulder', 1024.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1025.5, NULL, NULL, NULL);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1023.5, 'Michael Miles', 'election', 'yes');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1025.5, 'James Mayo', 'election', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state", "enr" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."state" AS "state", "RHS"."enr" AS "enr" FROM (SELECT * FROM "tryout" WHERE ("decision" = 'yes')) AS LHS INNER JOIN college AS RHS ON (LHS.cname = RHS.cname)) ORDER BY state, "state" NULLS LAST, "enr" NULLS LAST;

/*
Gold Result:
('Utah', 1022.5)
('Utah', 1022.5)
*/

-- Prediction Query
SELECT DISTINCT T1.state, T1.enr FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.decision = 'yes';

/*
Prediction Result:
('Utah', 1022.5)
*/