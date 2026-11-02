-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (13, 12);
INSERT INTO "Product" ("product_key") VALUES (13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(12,)
*/

-- Prediction Query
SELECT C1.CUSTOMER_ID FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER) AS C1 GROUP BY C1.CUSTOMER_ID HAVING COUNT(C1.PRODUCT_KEY) = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(12,)
*/