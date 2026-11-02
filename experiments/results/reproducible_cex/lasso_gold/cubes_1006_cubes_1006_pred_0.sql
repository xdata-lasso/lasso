-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Gina Carter', 'Hawaii', 1046.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('James Martin', 'Wyoming', 1052.5);
INSERT INTO "college" ("cname", "state", "enr") VALUES ('Pamela Romero', NULL, NULL);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1047.5, 'Troy Liu', 'everyone', 1048.5);
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1053.5, 'Tamara George', 'middle', 1054.5);
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1047.5, 'Gina Carter', 'striker', 'yes');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1047.5, 'Pamela Romero', 'striker', 'yes');
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1053.5, 'James Martin', 'striker', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "pname" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."pname" AS "pname", "LHS"."ycard" AS "ycard", "LHS"."hs" AS "hs", "RHS"."cname" AS "cname", "RHS"."ppos" AS "ppos", "RHS"."decision" AS "decision" FROM "player" AS "LHS" INNER JOIN (SELECT * FROM "tryout" WHERE ("decision" = 'yes' AND "ppos" = 'striker')) AS RHS ON (LHS.pid = RHS.pid)) ORDER BY pname, "pname" NULLS LAST;

/*
Gold Result:
('Tamara George',)
('Troy Liu',)
('Troy Liu',)
*/

-- Prediction Query
SELECT T1.pName FROM player AS T1 JOIN tryout AS T2 ON T1.pID = T2.pID WHERE T2.decision = 'yes' AND T2.pPos = 'striker';

/*
Prediction Result:
('Troy Liu',)
('Troy Liu',)
('Tamara George',)
*/