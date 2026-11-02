-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 16);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (12, 15);
INSERT INTO "Product" ("product_key") VALUES (12);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(15,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, COUNT(1) AS CNT FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER) AS T GROUP BY CUSTOMER_ID) AS T2 WHERE T2.CNT = (SELECT COUNT(1) FROM PRODUCT);

/*
Prediction Result:
(15,)
(16,)
*/