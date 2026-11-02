-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH CUSTOMER_PRODUCTS AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_KEY) AS PRODUCTS_BOUGHT FROM CUSTOMER GROUP BY CUSTOMER_ID) SELECT DISTINCT CUSTOMER_ID FROM CUSTOMER_PRODUCTS WHERE PRODUCTS_BOUGHT = (SELECT GROUP_CONCAT(PRODUCT_KEY) AS ALL_PRODUCTS FROM PRODUCT);

/*
Prediction Result:
*/