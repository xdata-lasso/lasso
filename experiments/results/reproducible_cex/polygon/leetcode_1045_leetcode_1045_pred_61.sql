-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 17);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 16);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(16,)
(17,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, CASE WHEN SUM(CNT) = P.B THEN CUSTOMER_ID END AS L FROM (SELECT CUSTOMER_ID, C.PRODUCT_KEY, COUNT(DISTINCT C.PRODUCT_KEY) AS CNT FROM CUSTOMER AS C INNER JOIN PRODUCT AS P ON C.PRODUCT_KEY = P.PRODUCT_KEY GROUP BY CUSTOMER_ID, C.PRODUCT_KEY) AS A CROSS JOIN (SELECT COUNT(PRODUCT_KEY) AS B FROM PRODUCT) AS P WHERE 1 = 1 GROUP BY CUSTOMER_ID) AS O WHERE NOT O.L IS NULL;

/*
Prediction Result:
*/