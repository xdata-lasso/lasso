-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 1), (NULL, 0), (NULL, 0), (NULL, 0);
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
WITH ALL_PRODUCTS AS (SELECT GROUP_CONCAT(PRODUCT_KEY) AS PRODUCTS FROM PRODUCT), CUST_PRODUCTS AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT (PRODUCT_KEY)) AS PRODUCTS FROM CUSTOMER GROUP BY CUSTOMER_ID) SELECT C.CUSTOMER_ID FROM CUST_PRODUCTS AS C JOIN ALL_PRODUCTS AS A ON A.PRODUCTS = C.PRODUCTS;

/*
Prediction Result:
*/