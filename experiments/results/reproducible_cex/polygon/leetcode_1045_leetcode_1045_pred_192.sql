-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 25);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (11, 14);
INSERT INTO "Product" ("product_key") VALUES (11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(14,)
*/

-- Prediction Query
WITH TMP AS (SELECT COUNT(*) AS PC FROM PRODUCT), TMP2 AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS TT FROM CUSTOMER AS C GROUP BY 1) SELECT CUSTOMER_ID FROM TMP2 CROSS JOIN TMP WHERE TT = PC;

/*
Prediction Result:
(14,)
*/