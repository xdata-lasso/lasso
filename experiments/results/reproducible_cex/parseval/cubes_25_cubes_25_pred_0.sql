-- Schema DDL
CREATE TABLE "i006" ("Id" INTEGER, "Name" TEXT, "Other_Columns" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i006 --
INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', '5k5swwqcgs');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', '9n8');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', '4');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (-734455130, '4h', 'rhs_9c5f33');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'ia2yp');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'uzhsrwbbp6lu');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'hvdlttilbnpr');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (2087640001, 'dposiie5unw', 'rhs_9c5f33');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (-1399556171, 'a9000t5c4eci', 'rhs_3f8e3f');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1149850321, 'e', NULL);

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', NULL);

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', NULL);

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', NULL);

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (-1585009206, '52zb', 'rhs_9c5f33');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (757448742, NULL, '4nrq');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, NULL, 'rofqyp5s5b');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, NULL, 'p');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, NULL, '02eutliqa11r');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (2137741668, NULL, 'rhs_9c5f33');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'ytoo3o9hl7');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'klex14ji');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', '7zwau2dwyr');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (-1021749117, '3pyu78d99r', 'rhs_9c5f33');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'jsl');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'b4yp5qi');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1, 'i00_bdba8e', 'rkf9vqx5');

INSERT INTO "i006" ("id", "name", "other_columns") VALUES (1836127587, 'f8jegd2', 'rhs_9c5f33');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, other_columns FROM (SELECT LHS.name AS name, LHS.id AS id, RHS.other_columns AS other_columns FROM (SELECT name, MAX(id) AS id FROM i006 GROUP BY name) AS LHS LEFT JOIN i006 AS RHS ON (LHS.name = RHS.name AND LHS.id = RHS.id)) ORDER BY id, name NULLS LAST, other_columns NULLS LAST;

/*
Gold Result:
(-1585009206, '52zb', 'rhs_9c5f33')
(-1399556171, 'a9000t5c4eci', 'rhs_3f8e3f')
(-1021749117, '3pyu78d99r', 'rhs_9c5f33')
(-734455130, '4h', 'rhs_9c5f33')
(1, 'i00_bdba8e', '4')
(1, 'i00_bdba8e', '5k5swwqcgs')
(1, 'i00_bdba8e', '7zwau2dwyr')
(1, 'i00_bdba8e', '9n8')
(1, 'i00_bdba8e', 'b4yp5qi')
(1, 'i00_bdba8e', 'hvdlttilbnpr')
(1, 'i00_bdba8e', 'ia2yp')
(1, 'i00_bdba8e', 'jsl')
(1, 'i00_bdba8e', 'klex14ji')
(1, 'i00_bdba8e', 'rkf9vqx5')
(1, 'i00_bdba8e', 'uzhsrwbbp6lu')
(1, 'i00_bdba8e', 'ytoo3o9hl7')
(1, 'i00_bdba8e', None)
(1, 'i00_bdba8e', None)
(1, 'i00_bdba8e', None)
(1149850321, 'e', None)
(1836127587, 'f8jegd2', 'rhs_9c5f33')
(2087640001, 'dposiie5unw', 'rhs_9c5f33')
(2137741668, None, None)
*/

-- Prediction Query
SELECT a.* FROM i006 AS a JOIN (SELECT name, MAX(id) AS maxid FROM i006 GROUP BY name) AS b ON a.id = b.maxid;

/*
Prediction Result:
(2137741668, None, 'rhs_9c5f33')
(-1021749117, '3pyu78d99r', 'rhs_9c5f33')
(-734455130, '4h', 'rhs_9c5f33')
(-1585009206, '52zb', 'rhs_9c5f33')
(-1399556171, 'a9000t5c4eci', 'rhs_3f8e3f')
(2087640001, 'dposiie5unw', 'rhs_9c5f33')
(1149850321, 'e', None)
(1836127587, 'f8jegd2', 'rhs_9c5f33')
(1, None, '02eutliqa11r')
(1, None, 'p')
(1, None, 'rofqyp5s5b')
(1, 'i00_bdba8e', None)
(1, 'i00_bdba8e', None)
(1, 'i00_bdba8e', None)
(1, 'i00_bdba8e', '4')
(1, 'i00_bdba8e', '5k5swwqcgs')
(1, 'i00_bdba8e', '7zwau2dwyr')
(1, 'i00_bdba8e', '9n8')
(1, 'i00_bdba8e', 'b4yp5qi')
(1, 'i00_bdba8e', 'hvdlttilbnpr')
(1, 'i00_bdba8e', 'ia2yp')
(1, 'i00_bdba8e', 'jsl')
(1, 'i00_bdba8e', 'klex14ji')
(1, 'i00_bdba8e', 'rkf9vqx5')
(1, 'i00_bdba8e', 'uzhsrwbbp6lu')
(1, 'i00_bdba8e', 'ytoo3o9hl7')
*/