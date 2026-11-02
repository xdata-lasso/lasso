-- Schema DDL
CREATE TABLE "College" ("cName" TEXT(20) PRIMARY KEY, "state" TEXT(2), "enr" REAL(5, 0));

CREATE TABLE "Player" ("pID" REAL(5, 0) PRIMARY KEY, "pName" TEXT(20), "yCard" TEXT(3), "HS" REAL(5, 0));

CREATE TABLE "Tryout" ("pID" REAL(5, 0), "cName" TEXT(20), "pPos" TEXT(8), "decision" TEXT(3), PRIMARY KEY ("pID", "cName"), FOREIGN KEY ("cName") REFERENCES "College" ("cName"), FOREIGN KEY ("pID") REFERENCES "Player" ("pID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: college --
INSERT INTO "college" ("cname", "state", "enr") VALUES ('cname_1', 'e4', 1.0);

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

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (10.0, 'pla_73808a', 'f5d', 10.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (11.0, 'pla_73808a', 'f5d', 11.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (12.0, 'pla_73808a', 'f5d', 12.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (13.0, 'pla_73808a', 'f5d', 13.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (14.0, 'pla_73808a', 'f5d', 14.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (15.0, 'pla_73808a', 'f5d', 15.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (16.0, 'pla_73808a', 'f5d', 16.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (17.0, 'pla_73808a', 'f5d', 17.0);

INSERT INTO "player" ("pid", "pname", "ycard", "hs") VALUES (18.0, 'pla_73808a', 'f5d', 18.0);

-- Inserting into table: tryout --
INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (1.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (2.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (3.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (4.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (5.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (6.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (7.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (8.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (9.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (10.0, 'cname_1', 't_abe54c', NULL);

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (11.0, 'cname_1', 't_abe54c', NULL);

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (12.0, 'cname_1', 't_abe54c', NULL);

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (13.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (14.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (15.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (16.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (17.0, 'cname_1', 'value', 'try_fe79d6');

INSERT INTO "tryout" ("pid", "cname", "ppos", "decision") VALUES (18.0, 'cname_1', 'value', 'try_fe79d6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "n" AS "count___" FROM (SELECT "decision", COUNT(*) AS "n" FROM "tryout" GROUP BY "decision") WHERE ("decision" = 'yes') ORDER BY count___;

/*
Gold Result:
*/

-- Prediction Query
SELECT COUNT(*) FROM tryout WHERE decision = 'yes';

/*
Prediction Result:
(0,)
*/