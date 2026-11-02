-- Schema DDL
CREATE TABLE "i038" ("id" INTEGER, "name" TEXT, "city" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i038 (id, name, city) VALUES (1, 'Alice', 'New York');
INSERT INTO i038 (id, name, city) VALUES (10, 'Bob', 'Los Angeles');
INSERT INTO i038 (id, name, city) VALUES (2, 'Bob', 'Los Angeles');
INSERT INTO i038 (id, name, city) VALUES (5, 'Carol', 'Chicago');
INSERT INTO i038 (id, name, city) VALUES (3, 'Carol', 'Chicago');
INSERT INTO i038 (id, name, city) VALUES (4, 'Carol', 'Chicago');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, name, city FROM (SELECT LHS.id AS id, LHS.name AS name, LHS.city AS city, RHS.n AS n FROM i038 AS LHS LEFT JOIN (SELECT city, name, COUNT(*) AS n FROM i038 GROUP BY city, name) AS RHS ON (LHS.name = RHS.name AND LHS.city = RHS.city)) WHERE (n > 1) ORDER BY id, name NULLS LAST, city NULLS LAST;

/*
Gold Result:
(2, 'Bob', 'Los Angeles')
(3, 'Carol', 'Chicago')
(4, 'Carol', 'Chicago')
(5, 'Carol', 'Chicago')
(10, 'Bob', 'Los Angeles')
*/

-- Prediction Query
SELECT s.id, t.name, t.city FROM i038 AS s JOIN (SELECT name, city, COUNT(*) AS qty FROM i038 GROUP BY name, city HAVING COUNT(*) > 1) AS t ON s.name = t.name AND s.city = t.city;

/*
Prediction Result:
(10, 'Bob', 'Los Angeles')
(2, 'Bob', 'Los Angeles')
(5, 'Carol', 'Chicago')
(3, 'Carol', 'Chicago')
(4, 'Carol', 'Chicago')
*/