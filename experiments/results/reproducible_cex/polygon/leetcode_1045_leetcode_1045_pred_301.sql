-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (10, 13);
INSERT INTO "Product" ("product_key") VALUES (10);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(13,)
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID, COUNT(DISTINCT (PRODUCT_KEY)) AS COUNT1 FROM CUSTOMER GROUP BY CUSTOMER_ID), CTE2 AS (SELECT COUNT(*) AS COUNT2 FROM PRODUCT) SELECT CTE1.CUSTOMER_ID FROM CTE1 JOIN CTE2 ON CTE1.COUNT1 = CTE2.COUNT2 WHERE CTE1.COUNT1 = CTE2.COUNT2;

/*
Prediction Result:
(13,)
*/