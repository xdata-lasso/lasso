-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (15, 16);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 18);
INSERT INTO "Product" ("product_key") VALUES (15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(16,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT DISTINCT * FROM CUSTOMER) AS T GROUP BY CUSTOMER_ID HAVING COUNT(0) = (SELECT COUNT(0) FROM PRODUCT);

/*
Prediction Result:
(16,)
(18,)
*/