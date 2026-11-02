-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UCLA', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('USC', 'CA', 30000);
INSERT INTO "College" ("cName", "state", "enr") VALUES ('UT', 'TX', 50000);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (201, 'Dan', 'no', 800);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (202, 'Eve', 'yes', 900);
INSERT INTO "Player" ("pID", "pName", "yCard", "HS") VALUES (203, 'Frank', 'no', 1100);
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (201, 'UCLA', 'striker', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (202, 'UCLA', 'mid', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (203, 'USC', 'goalie', 'yes');
INSERT INTO "Tryout" ("pID", "cName", "pPos", "decision") VALUES (201, 'UT', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state", "enr" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."state" AS "state", "RHS"."enr" AS "enr" FROM (SELECT * FROM "tryout" WHERE ("decision" = 'yes')) AS LHS INNER JOIN college AS RHS ON (LHS.cname = RHS.cname)) ORDER BY state, "state" NULLS LAST, "enr" NULLS LAST;

/*
Gold Result:
('CA', 30000.0)
('CA', 30000.0)
('CA', 30000.0)
('TX', 50000.0)
*/

-- Prediction Query
SELECT DISTINCT T1.state, T1.enr FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.decision = 'yes';

/*
Prediction Result:
('CA', 30000.0)
('TX', 50000.0)
*/