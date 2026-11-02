-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('rhs_77c58a', 'rhs_d93f26', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_c7c129', 'rhs_d93f26', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_2', 'rhs_51b8f9', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_295a19', 'e4', 4.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_73808a', 'f5d', 1.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'rhs_77c58a', 'try_45bc15', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_c7c129', 'try_45bc15', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_295a19', 'try_85d2c6', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state", "enr" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."state" AS "state", "RHS"."enr" AS "enr" FROM (SELECT * FROM "tryout" WHERE ("decision" = 'yes')) AS LHS INNER JOIN college AS RHS ON (LHS.cname = RHS.cname)) ORDER BY state, "state" NULLS LAST, "enr" NULLS LAST;

/*
Gold Result:
('e4', 4.0)
('rhs_d93f26', 1.0)
('rhs_d93f26', 1.0)
*/

-- Prediction Query
SELECT DISTINCT T1.state, T1.enr FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.decision = 'yes';

/*
Prediction Result:
('rhs_d93f26', 1.0)
('e4', 4.0)
*/