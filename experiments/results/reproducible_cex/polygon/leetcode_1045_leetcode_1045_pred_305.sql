-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (9, 13);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (9, 12);
INSERT INTO "Product" ("product_key") VALUES (9);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(12,)
(13,)
*/

-- Prediction Query
WITH CUSTOMER_INFO AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS PRODUCT_COUNT FROM CUSTOMER GROUP BY 1) SELECT CUSTOMER_ID FROM CUSTOMER_INFO WHERE PRODUCT_COUNT = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(12,)
(13,)
*/