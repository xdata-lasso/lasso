-- Schema DDL
CREATE TABLE "r" ("a" INTEGER, "b" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: r --
INSERT INTO "r" ("a", "b") VALUES (-55602865, 1);

INSERT INTO "r" ("a", "b") VALUES (-59984348, NULL);

INSERT INTO "r" ("a", "b") VALUES (-664303813, NULL);

INSERT INTO "r" ("a", "b") VALUES (-1022641847, NULL);

INSERT INTO "r" ("a", "b") VALUES (-1726781632, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(*) AS A FROM R AS X;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(Y.B) FROM R AS Y;

/*
Prediction Result:
(1,)
*/