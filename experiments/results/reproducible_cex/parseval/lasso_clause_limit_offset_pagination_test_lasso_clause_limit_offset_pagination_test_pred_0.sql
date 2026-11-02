-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: items --
INSERT INTO "items" ("id", "val", "score") VALUES (-2147483648, 1.0, 582.588439);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483647, 1.0, 680.190136);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483646, 1.0, 487.053947);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483645, 1.0, 486.033807);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483644, 1.0, 345.329712);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483643, 1.0, 833.684115);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483642, 1.0, 261.897639);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483641, 1.0, 97.952323);

INSERT INTO "items" ("id", "val", "score") VALUES (2, 1.0, 171.746906);

INSERT INTO "items" ("id", "val", "score") VALUES (3, 1.0, 557.512061);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483640, 1.0, 868.436572);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483637, 1.0, 537.136345);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483636, 1.0, 38.937207);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483635, 1.0, 249.706432);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483634, 1.0, 99.523333);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483633, 1.0, 314.813297);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483632, 1.0, 328.996339);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483631, NULL, 906.21648);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483630, NULL, 483.665643);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483629, NULL, 818.685402);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483628, NULL, 804.971537);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483627, NULL, 119.752245);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483626, NULL, 134.487977);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483625, NULL, 941.961117);

INSERT INTO "items" ("id", "val", "score") VALUES (-2147483624, NULL, 4.751658);

INSERT INTO "items" ("id", "val", "score") VALUES (4, 441.165949, 797.015047);

INSERT INTO "items" ("id", "val", "score") VALUES (5, 241.913711, 759.708817);

INSERT INTO "items" ("id", "val", "score") VALUES (6, 882.963176, 841.297061);

INSERT INTO "items" ("id", "val", "score") VALUES (7, 294.861575, 268.234631);

INSERT INTO "items" ("id", "val", "score") VALUES (8, 349.034361, 30.774742);

INSERT INTO "items" ("id", "val", "score") VALUES (9, 21.869121, 235.96352);

INSERT INTO "items" ("id", "val", "score") VALUES (10, 185.86457, 737.440743);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(92.932285,)
(10.9345605,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(737.440743,)
(235.96352,)
(582.588439,)
(680.190136,)
(487.053947,)
(486.033807,)
(345.329712,)
(833.684115,)
(261.897639,)
(97.952323,)
*/