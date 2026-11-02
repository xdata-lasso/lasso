-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (11, 16);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 16);
INSERT INTO "Product" ("product_key") VALUES (11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(16,)
*/

-- Prediction Query
WITH TEMP AS (SELECT DISTINCT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS CNT FROM CUSTOMER GROUP BY CUSTOMER_ID) SELECT TMP.CUSTOMER_ID FROM TEMP AS TMP WHERE TMP.CNT = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(16,)
*/