-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (8, 12);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (8, 11);
INSERT INTO "Product" ("product_key") VALUES (8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(11,)
(12,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, IIF(COUNT(DISTINCT PRODUCT_KEY) = (SELECT COUNT(*) FROM PRODUCT), 1, 0) AS VAL FROM CUSTOMER GROUP BY CUSTOMER_ID HAVING VAL = 1) AS A;

/*
Prediction Result:
(11,)
(12,)
*/