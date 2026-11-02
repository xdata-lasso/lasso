-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH FIRST_PASS AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS TOTAL_PRODUCTS FROM CUSTOMER WHERE LENGTH(PRODUCT_KEY) > 0 GROUP BY 1) SELECT CUSTOMER_ID FROM FIRST_PASS WHERE TOTAL_PRODUCTS = (SELECT COUNT(DISTINCT PRODUCT_KEY) FROM CUSTOMER);

/*
Prediction Result:
*/