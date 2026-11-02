-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 15);
INSERT INTO "Product" ("product_key") VALUES (0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
WITH CUSTOMER_PRODUCT_COUNT AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS COUNT_PRODUCT_KEY FROM CUSTOMER GROUP BY CUSTOMER_ID), PRODUCT_COUNT AS (SELECT COUNT(*) AS COUNT_PRODUCT_KEY FROM PRODUCT) SELECT A.CUSTOMER_ID FROM CUSTOMER_PRODUCT_COUNT AS A CROSS JOIN PRODUCT_COUNT AS B WHERE A.COUNT_PRODUCT_KEY = B.COUNT_PRODUCT_KEY;

/*
Prediction Result:
*/