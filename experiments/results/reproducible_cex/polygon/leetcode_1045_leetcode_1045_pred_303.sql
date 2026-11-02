-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 15);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (20, 15);
INSERT INTO "Product" ("product_key") VALUES (20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(15,)
*/

-- Prediction Query
WITH UNIQUECUSTOMERPRODUCT AS (SELECT DISTINCT * FROM CUSTOMER), PRODUTCOUNT AS (SELECT COUNT(*) AS CNT FROM PRODUCT) SELECT U.CUSTOMER_ID FROM UNIQUECUSTOMERPRODUCT AS U LEFT OUTER JOIN PRODUCT AS P USING (PRODUCT_KEY) GROUP BY U.CUSTOMER_ID HAVING COUNT(DISTINCT U.PRODUCT_KEY) = (SELECT * FROM PRODUTCOUNT);

/*
Prediction Result:
(15,)
*/