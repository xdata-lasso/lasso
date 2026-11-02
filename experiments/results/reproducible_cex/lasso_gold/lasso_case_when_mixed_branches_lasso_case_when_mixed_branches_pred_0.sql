-- Schema DDL
CREATE TABLE sales (sale_id INTEGER PRIMARY KEY, region TEXT, amount REAL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "sales" ("sale_id", "region", "amount") VALUES (1012, 'North', 1013.5);
INSERT INTO "sales" ("sale_id", "region", "amount") VALUES (1019, NULL, 1020.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN region = 'North' THEN amount ELSE 0 END) AS REAL) * 100 / SUM(amount) FROM sales;

/*
Gold Result:
(49.82792527040315,)
*/

-- Prediction Query
SELECT (CAST(SUM(CASE WHEN region = 'North' THEN amount ELSE 0 END) AS REAL) / CAST(SUM(amount) AS REAL)) * 100 FROM sales;

/*
Prediction Result:
(49.82792527040314,)
*/