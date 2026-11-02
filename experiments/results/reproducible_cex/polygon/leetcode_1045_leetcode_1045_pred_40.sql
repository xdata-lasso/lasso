-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (7, 10);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (7, 10);
INSERT INTO "Product" ("product_key") VALUES (7);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(10,)
*/

-- Prediction Query
WITH CTE AS (SELECT COUNT(*) FROM PRODUCT) SELECT CUSTOMER_ID FROM CUSTOMER GROUP BY 1 HAVING COUNT(DISTINCT PRODUCT_KEY) = (SELECT * FROM CTE);

/*
Prediction Result:
(10,)
*/