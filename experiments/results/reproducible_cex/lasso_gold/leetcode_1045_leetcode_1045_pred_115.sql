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
WITH TEMP AS (SELECT DISTINCT P.PRODUCT_KEY, C.CUSTOMER_ID FROM PRODUCT AS P JOIN CUSTOMER AS C USING (PRODUCT_KEY)) SELECT CUSTOMER_ID FROM TEMP GROUP BY CUSTOMER_ID HAVING COUNT(PRODUCT_KEY) = (SELECT COUNT(PRODUCT_KEY) FROM PRODUCT);

/*
Prediction Result:
*/