-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_e77015', 'e4', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_031933', 'e4', 2.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_3856d0', 'e4', 3.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_432156', 'e4', 4.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_02f836', 'e4', 5.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('try_9880fa', 'e4', 6.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('lhs_871dfa', 'e4', 7.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_73808a', 'f5d', 1.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_e77015', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_031933', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_3856d0', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_432156', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_02f836', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'try_9880fa', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'lhs_871dfa', 'lhs_56ace9', 'lhs_1b39b3');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT ppos FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, LHS.n AS n FROM (SELECT LHS.pid AS pid, LHS.cname AS cname, LHS.ppos AS ppos, LHS.decision AS decision, RHS.n AS n FROM tryout AS LHS INNER JOIN (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid) AS RHS ON (LHS.pid = RHS.pid)) AS LHS INNER JOIN (SELECT MAX(n) AS n FROM (SELECT pid, COUNT(*) AS n FROM tryout GROUP BY pid)) AS RHS ON (LHS.n = RHS.n)) ORDER BY ppos;

/*
Gold Result:
('lhs_56ace9',)
('t_abe54c',)
*/

-- Prediction Query
SELECT pPos FROM tryout GROUP BY pPos ORDER BY COUNT(*) DESC, pPos NULLS LAST LIMIT 1;

/*
Prediction Result:
('t_abe54c',)
*/