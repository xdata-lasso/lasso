-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(13,)
*/

-- Prediction Query
WITH CTE AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER), CTE1 AS (SELECT CUSTOMER_ID, COUNT(*) AS CNT FROM CTE GROUP BY CUSTOMER_ID HAVING COUNT(*) = (SELECT COUNT(*) FROM PRODUCT)) SELECT CUSTOMER_ID FROM CTE1;

/*
Prediction Result:
*/