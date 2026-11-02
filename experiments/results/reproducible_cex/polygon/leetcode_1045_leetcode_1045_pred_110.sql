-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 14);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 13);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(13,)
(14,)
*/

-- Prediction Query
WITH CTE_FILTER AS (SELECT C.CUSTOMER_ID, C.PRODUCT_KEY FROM CUSTOMER AS C INNER JOIN PRODUCT AS P ON C.PRODUCT_KEY = P.PRODUCT_KEY) SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS COUNTED FROM CTE_FILTER GROUP BY CUSTOMER_ID HAVING COUNTED = (SELECT COUNT(DISTINCT PRODUCT_KEY) FROM PRODUCT)) AS A;

/*
Prediction Result:
*/