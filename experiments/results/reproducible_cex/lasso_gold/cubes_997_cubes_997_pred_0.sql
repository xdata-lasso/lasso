-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Martin Rodriguez', 'Nevada', 1051.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Sherri Baker', 'Connecticut', 1054.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1052.5, 'Charles', 'coach', 1053.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1055.5, 'Charles', 'sound', 1056.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1052.5, 'Martin Rodriguez', 'long', 'about');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1055.5, 'Sherri Baker', 'could', 'movement');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT "LHS"."cname" AS "cname", "LHS"."state" AS "state", "LHS"."enr" AS "enr", "LHS"."pid" AS "pid", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."pname" AS "pname", "RHS"."ycard" AS "ycard", "RHS"."hs" AS "hs" FROM (SELECT "LHS"."cname" AS "cname", "LHS"."state" AS "state", "LHS"."enr" AS "enr", "RHS"."pid" AS "pid", "RHS"."ppos" AS "ppos", "RHS"."decision" AS "decision" FROM "college" AS "LHS" INNER JOIN "tryout" AS "RHS" ON ("LHS"."cname" = "RHS"."cname")) AS "LHS" INNER JOIN (SELECT * FROM "player" WHERE ("pname" = 'Charles')) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('Connecticut',)
('Nevada',)
*/

-- Prediction Query
SELECT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName JOIN player AS T3 ON T2.pID = T3.pID WHERE T3.pName = 'Charles';

/*
Prediction Result:
('Nevada',)
('Connecticut',)
*/