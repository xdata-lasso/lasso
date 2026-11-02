-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (11, 22);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 27);
INSERT INTO "Product" ("product_key") VALUES (11);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(22,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT A.CUSTOMER_ID, (A.PROD_CNT - B.PROD_CNT) AS REM FROM (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS PROD_CNT FROM CUSTOMER GROUP BY CUSTOMER_ID) AS A CROSS JOIN (SELECT COUNT(*) AS PROD_CNT FROM PRODUCT) AS B) AS F WHERE F.REM = 0;

/*
Prediction Result:
(22,)
*/