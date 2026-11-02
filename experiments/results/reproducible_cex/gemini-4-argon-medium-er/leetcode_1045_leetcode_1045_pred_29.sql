-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_key") VALUES (0);
INSERT INTO "Product" ("product_key") VALUES (1);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
SELECT SUB.CUSTOMER_ID FROM (SELECT C.CUSTOMER_ID, SUM(DISTINCT C.PRODUCT_KEY) AS SUB_TOTAL, SUM(DISTINCT P.PRODUCT_KEY) AS TOTAL FROM CUSTOMER AS C CROSS JOIN PRODUCT AS P GROUP BY CUSTOMER_ID) AS SUB WHERE SUB.SUB_TOTAL = SUB.TOTAL;

/*
Prediction Result:
(1,)
*/