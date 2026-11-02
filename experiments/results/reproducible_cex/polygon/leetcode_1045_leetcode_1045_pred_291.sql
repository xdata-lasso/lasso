-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 9);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 8);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(8,)
(9,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM CUSTOMER GROUP BY CUSTOMER_ID HAVING SUM(DISTINCT (PRODUCT_KEY)) = (SELECT SUM(PRODUCT_KEY) FROM PRODUCT);

/*
Prediction Result:
*/