-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, PRODUCT_KEY, DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY PRODUCT_KEY) AS NUM_PRODUCT FROM CUSTOMER) AS TEMP WHERE NUM_PRODUCT IN (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
*/