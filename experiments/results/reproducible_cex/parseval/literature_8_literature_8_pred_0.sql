-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER, "c" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: r --
INSERT INTO "r" ("a", "b", "c") VALUES (-55602865, 1, -59984348);

INSERT INTO "r" ("a", "b", "c") VALUES (5, 1, 0);

INSERT INTO "r" ("a", "b", "c") VALUES (-664303813, 1, -1022641847);

INSERT INTO "r" ("a", "b", "c") VALUES (-1726781632, 1, 247012447);

INSERT INTO "r" ("a", "b", "c") VALUES (5, 1, 0);

INSERT INTO "r" ("a", "b", "c") VALUES (5, 1, 0);

INSERT INTO "r" ("a", "b", "c") VALUES (-1980249628, 1, -734455130);

INSERT INTO "r" ("a", "b", "c") VALUES (1, 1, 0);

INSERT INTO "r" ("a", "b", "c") VALUES (1744686505, 1, -1633151678);

INSERT INTO "r" ("a", "b", "c") VALUES (5, 1, 1);

INSERT INTO "r" ("a", "b", "c") VALUES (-252690330, NULL, 1115440883);

INSERT INTO "r" ("a", "b", "c") VALUES (5, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT X.B AS XB FROM R AS X WHERE X.A = 5 AND X.C < 1;

/*
Gold Result:
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT X.B AS XB FROM R AS X WHERE X.A < 10;

/*
Prediction Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
(None,)
*/