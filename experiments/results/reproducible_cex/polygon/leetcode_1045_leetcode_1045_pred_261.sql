-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (23, 25);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (24, 25);
INSERT INTO "Product" ("product_key") VALUES (23);
INSERT INTO "Product" ("product_key") VALUES (24);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(25,)
*/

-- Prediction Query
WITH PURCHASES AS (SELECT DISTINCT A.PRODUCT_KEY, B.CUSTOMER_ID FROM PRODUCT AS A LEFT JOIN CUSTOMER AS B ON A.PRODUCT_KEY = B.PRODUCT_KEY) SELECT CUSTOMER_ID FROM PURCHASES GROUP BY 1 HAVING COUNT(*) = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(25,)
*/