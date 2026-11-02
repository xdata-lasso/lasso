-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "customer" ("product_key", "customer_id") VALUES (NULL, 1038);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1038,)
*/

-- Prediction Query
WITH TOTAL_PROD(TOTAL) AS (SELECT COUNT(DISTINCT PRODUCT_KEY) FROM PRODUCT), CON_PROD(CUSTOMER_ID, TOTAL) AS (SELECT A.CUSTOMER_ID, COUNT(DISTINCT A.PRODUCT_KEY) FROM CUSTOMER AS A JOIN PRODUCT AS B ON A.PRODUCT_KEY = B.PRODUCT_KEY GROUP BY A.CUSTOMER_ID) SELECT DISTINCT CUSTOMER_ID FROM TOTAL_PROD CROSS JOIN CON_PROD WHERE TOTAL_PROD.TOTAL = CON_PROD.TOTAL;

/*
Prediction Result:
*/