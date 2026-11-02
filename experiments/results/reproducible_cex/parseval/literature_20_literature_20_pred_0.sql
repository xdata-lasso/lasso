-- Schema DDL
CREATE TABLE "r" ("a1" INTEGER, "a2" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: r --
INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (3, 1);

INSERT INTO "r" ("a1", "a2") VALUES (4, 1);

INSERT INTO "r" ("a1", "a2") VALUES (2, 1);

INSERT INTO "r" ("a1", "a2") VALUES (2, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 3);

INSERT INTO "r" ("a1", "a2") VALUES (1, 4);

INSERT INTO "r" ("a1", "a2") VALUES (1, 2);

INSERT INTO "r" ("a1", "a2") VALUES (1, 2);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, NULL);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);

INSERT INTO "r" ("a1", "a2") VALUES (1, NULL);

INSERT INTO "r" ("a1", "a2") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT Y.A1 AS A1, Y.A2 AS A2 FROM R AS X CROSS JOIN R AS Y WHERE X.A1 = Y.A1 AND X.A2 = Y.A2;

/*
Gold Result:
(1, 1)
(3, 1)
(4, 1)
(2, 1)
(1, 3)
(1, 4)
(1, 2)
*/

-- Prediction Query
SELECT DISTINCT X.A1 AS A1, X.A2 AS A2 FROM R AS X;

/*
Prediction Result:
(1, 1)
(3, 1)
(4, 1)
(2, 1)
(1, 3)
(1, 4)
(1, 2)
(1, None)
*/