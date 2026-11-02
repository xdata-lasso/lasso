-- Schema DDL
CREATE TABLE "i019" ("id" INTEGER, "age" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO i019 (id, age) VALUES (1, 40);
INSERT INTO i019 (id, age) VALUES (1, 10);
INSERT INTO i019 (id, age) VALUES (2, 20);
INSERT INTO i019 (id, age) VALUES (2, 20);
INSERT INTO i019 (id, age) VALUES (3, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, age, n FROM (SELECT LHS.id AS id, LHS.age AS age, RHS.n AS n FROM i019 AS LHS INNER JOIN (SELECT age, COUNT(*) AS n FROM i019 GROUP BY age) AS RHS ON (LHS.age = RHS.age)) ORDER BY id, age NULLS LAST, n NULLS LAST;

/*
Gold Result:
(1, 10, 1)
(1, 40, 2)
(2, 20, 2)
(2, 20, 2)
(3, 40, 2)
*/

-- Prediction Query
SELECT S.id, S.age, C.cnt FROM i019 AS S JOIN (SELECT age, COUNT(age) AS cnt FROM i019 GROUP BY age) AS C ON S.age = C.age;

/*
Prediction Result:
(1, 40, 2)
(1, 10, 1)
(2, 20, 2)
(2, 20, 2)
(3, 40, 2)
*/