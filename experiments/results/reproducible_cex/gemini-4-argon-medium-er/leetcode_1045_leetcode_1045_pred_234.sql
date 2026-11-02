-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Product" ("product_key") VALUES (1);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 100);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID, PRODUCT_KEY, ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ID) AS COUNTER FROM CUSTOMER GROUP BY CUSTOMER_ID, PRODUCT_KEY ORDER BY CUSTOMER_ID, PRODUCT_KEY NULLS LAST, COUNTER NULLS LAST) SELECT CUSTOMER_ID FROM CTE WHERE COUNTER = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(100,)
*/