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
WITH NODUPCUST AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER) SELECT CUSTOMER_ID FROM NODUPCUST GROUP BY CUSTOMER_ID HAVING COUNT(PRODUCT_KEY) = (SELECT COUNT(*) AS PRODCOUNT FROM PRODUCT);

/*
Prediction Result:
(12,)
*/