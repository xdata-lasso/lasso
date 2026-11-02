-- Schema DDL
CREATE TABLE "i019" ("id" INTEGER, "age" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "i019" ("id", "age") VALUES (1004, 1005);
INSERT INTO "i019" ("id", "age") VALUES (1006, 1005);
INSERT INTO "i019" ("id", "age") VALUES (NULL, 1008);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, age, n FROM (SELECT LHS.id AS id, LHS.age AS age, RHS.n AS n FROM i019 AS LHS INNER JOIN (SELECT age, COUNT(*) AS n FROM i019 GROUP BY age) AS RHS ON (LHS.age = RHS.age)) ORDER BY id, age NULLS LAST, n NULLS LAST;

/*
Gold Result:
(None, 1008, 1)
(1004, 1005, 2)
(1006, 1005, 2)
*/

-- Prediction Query
SELECT S.id, S.age, C.cnt FROM i019 AS S JOIN (SELECT age, COUNT(age) AS cnt FROM i019 GROUP BY age) AS C ON S.age = C.age;

/*
Prediction Result:
(1004, 1005, 2)
(1006, 1005, 2)
(None, 1008, 1)
*/