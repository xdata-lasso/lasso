-- Schema DDL
CREATE TABLE items (id INTEGER PRIMARY KEY, val REAL, score REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "items" ("id", "val", "score") VALUES (1001, 1011.5, 1021.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1002, 1016.5, 1028.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1003, 1021.5, 1035.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1004, 1026.5, 1042.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1005, 1031.5, 1049.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1006, 1036.5, 1056.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1007, 1041.5, 1063.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1008, 1046.5, 1070.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1009, 1051.5, 1077.5);
INSERT INTO "items" ("id", "val", "score") VALUES (1010, 1056.5, 1084.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT val / 2.0 FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 2 OFFSET 5;

/*
Gold Result:
(515.75,)
(513.25,)
*/

-- Prediction Query
SELECT score FROM items ORDER BY val DESC, items.id NULLS LAST LIMIT 10 OFFSET 5;

/*
Prediction Result:
(1049.5,)
(1042.5,)
(1035.5,)
(1028.5,)
(1021.5,)
*/