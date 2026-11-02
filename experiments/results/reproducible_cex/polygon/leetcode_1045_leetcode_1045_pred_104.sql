-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 22);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 15);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(15,)
(22,)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, COUNT(PRODUCT_KEY) OVER (PARTITION BY CUSTOMER_ID) AS CNT FROM (SELECT DISTINCT * FROM CUSTOMER) AS T) SELECT DISTINCT CUSTOMER_ID FROM CTE WHERE CNT = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(15,)
(22,)
*/