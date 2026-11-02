-- Schema DDL
CREATE TABLE "i019" ("id" INTEGER, "age" INTEGER);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i019 (id, age) VALUES (30, 10);
INSERT INTO i019 (id, age) VALUES (10, 10);
INSERT INTO i019 (id, age) VALUES (20, 25);
INSERT INTO i019 (id, age) VALUES (5, 40);
INSERT INTO i019 (id, age) VALUES (15, 40);
INSERT INTO i019 (id, age) VALUES (25, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, age, n FROM (SELECT LHS.id AS id, LHS.age AS age, RHS.n AS n FROM i019 AS LHS INNER JOIN (SELECT age, COUNT(*) AS n FROM i019 GROUP BY age) AS RHS ON (LHS.age = RHS.age)) ORDER BY id, age NULLS LAST, n NULLS LAST;

/*
Gold Result:
(5, 40, 3)
(10, 10, 2)
(15, 40, 3)
(20, 25, 1)
(25, 40, 3)
(30, 10, 2)
*/

-- Prediction Query
SELECT S.id, S.age, C.cnt FROM i019 AS S JOIN (SELECT age, COUNT(age) AS cnt FROM i019 GROUP BY age) AS C ON S.age = C.age;

/*
Prediction Result:
(30, 10, 2)
(10, 10, 2)
(20, 25, 1)
(5, 40, 3)
(15, 40, 3)
(25, 40, 3)
*/