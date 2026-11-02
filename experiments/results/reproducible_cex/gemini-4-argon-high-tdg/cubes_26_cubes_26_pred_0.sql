-- Schema DDL
CREATE TABLE "i051" ("id" INTEGER, "category" TEXT, "date" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO i051 (id, category, date) VALUES (1, 'cat_old', '2023-01-01');
INSERT INTO i051 (id, category, date) VALUES (1, 'cat_new', '2023-01-10');
INSERT INTO i051 (id, category, date) VALUES (2, 'cat_other', '2023-01-05');
INSERT INTO i051 (id, category, date) VALUES (2, 'cat_old', '2023-01-02');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT id, category, maxdate AS date FROM (SELECT LHS.id AS id, LHS.category AS category, LHS.date AS date, LHS.maxdate AS maxdate, RHS.category AS category_other FROM (SELECT id, category, date, MAX(date) OVER () AS maxdate FROM i051) AS LHS INNER JOIN i051 AS RHS ON (LHS.id = RHS.id AND LHS.maxdate = RHS.date)) ORDER BY id, category NULLS LAST, date NULLS LAST;

/*
Gold Result:
(1, 'cat_new', '2023-01-10')
(1, 'cat_old', '2023-01-10')
*/

-- Prediction Query
SELECT t1.* FROM i051 AS t1 JOIN (SELECT category, MAX(date) AS MAXDATE FROM i051 GROUP BY category) AS t2 ON T1.category = t2.category AND t1.date = t2.MAXDATE;

/*
Prediction Result:
(1, 'cat_new', '2023-01-10')
(2, 'cat_other', '2023-01-05')
(2, 'cat_old', '2023-01-02')
*/