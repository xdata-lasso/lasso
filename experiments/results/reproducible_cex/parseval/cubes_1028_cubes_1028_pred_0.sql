-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('t1__7f43c5', 't1__ba1108', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('C', 't1__ba1108', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('O', 't1__ba1108', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('A', 't1__ba1108', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('Q', 'e4', 5.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('G', 'e4', 6.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('?', 't1__ba1108', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('_', 't1__ba1108', 1.0);

INSERT INTO "college" ("cname", "state", "enr") VALUES ('t2__dc9102', 'e4', 9.0);

-- Inserting into table: player --
INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (1.0, 'pla_73808a', 'f5d', 1.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (2.0, 'pla_73808a', 'f5d', 2.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (3.0, 'pla_73808a', 'f5d', 3.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (4.0, 'pla_73808a', 'f5d', 4.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (5.0, 'pla_73808a', 'f5d', 5.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (6.0, 'pla_73808a', 'f5d', 6.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (7.0, 'pla_73808a', 'f5d', 7.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (8.0, 'pla_73808a', 'f5d', 8.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (9.0, 'pla_73808a', 'f5d', 9.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 't1__7f43c5', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (2.0, 't1__7f43c5', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'Q', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (2.0, 'Q', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (2.0, 'G', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (3.0, 'G', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (2.0, 'O', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (4.0, 'O', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'O', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (5.0, 'O', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (3.0, '?', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (2.0, '?', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (5.0, '_', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (6.0, '_', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (7.0, 't1__7f43c5', 'value', 't2__9f504f');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (8.0, 't1__7f43c5', 'value', 't2__2fd2ec');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 't2__dc9102', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (8.0, 't2__dc9102', 't_abe54c', 'ba1');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (4.0, 't1__7f43c5', 't_abe54c', 'yes');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (9.0, 't1__7f43c5', 't_abe54c', 'yes');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "state" FROM (SELECT "LHS"."pid" AS "pid", "LHS"."cname" AS "cname", "LHS"."ppos" AS "ppos", "LHS"."decision" AS "decision", "RHS"."state" AS "state", "RHS"."enr" AS "enr" FROM (SELECT * FROM "tryout" WHERE ("decision" = 'yes')) AS LHS INNER JOIN college AS RHS ON (LHS.cname = RHS.cname)) ORDER BY state, "state" NULLS LAST;

/*
Gold Result:
('e4',)
('e4',)
('e4',)
('e4',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
('t1__ba1108',)
*/

-- Prediction Query
SELECT DISTINCT T1.state FROM college AS T1 JOIN tryout AS T2 ON T1.cName = T2.cName WHERE T2.decision = 'yes';

/*
Prediction Result:
('t1__ba1108',)
('e4',)
*/