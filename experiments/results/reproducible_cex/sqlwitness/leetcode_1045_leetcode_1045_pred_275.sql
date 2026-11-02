-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 1), (NULL, 0), (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(0,)
(1,)
*/

-- Prediction Query
WITH T3 AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER) SELECT DISTINCT CUSTOMER_ID FROM (SELECT T3.CUSTOMER_ID, COUNT(*) AS TOTAL FROM T3 GROUP BY T3.CUSTOMER_ID) AS T2 WHERE T2.TOTAL = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
*/