-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("customer_id", "product_key") VALUES (1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH A AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_KEY) AS NN FROM CUSTOMER GROUP BY CUSTOMER_ID), B AS (SELECT GROUP_CONCAT(DISTINCT PRODUCT_KEY) AS NN2 FROM PRODUCT) SELECT DISTINCT CUSTOMER_ID FROM A WHERE NN IN (SELECT NN2 FROM B);

/*
Prediction Result:
*/