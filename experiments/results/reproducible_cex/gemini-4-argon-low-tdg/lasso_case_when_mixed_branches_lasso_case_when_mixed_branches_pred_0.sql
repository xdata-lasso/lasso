-- Schema DDL
CREATE TABLE sales (sale_id INTEGER PRIMARY KEY, region TEXT, amount REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO sales (sale_id, region, amount) VALUES (1, 'North', 10.0);
INSERT INTO sales (sale_id, region, amount) VALUES (2, 'South', 20.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN region = 'North' THEN amount ELSE 0 END) AS REAL) * 100 / SUM(amount) FROM sales;

/*
Gold Result:
(33.333333333333336,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN region = 'North' THEN amount ELSE 0 END) AS REAL) / CAST(SUM(amount) AS REAL)) * 100 FROM sales;

/*
Prediction Result:
(33.33333333333333,)
*/