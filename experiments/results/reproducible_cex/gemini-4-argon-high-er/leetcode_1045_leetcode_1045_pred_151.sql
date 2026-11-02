-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Product (product_key) VALUES (1);
INSERT INTO Customer (product_key, customer_id) VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
WITH CT AS (SELECT C.CUSTOMER_ID, P.PRODUCT_KEY, COUNT(DISTINCT P.PRODUCT_KEY) AS CNTRR FROM PRODUCT AS P LEFT JOIN CUSTOMER AS C ON P.PRODUCT_KEY = C.PRODUCT_KEY GROUP BY C.CUSTOMER_ID ORDER BY P.PRODUCT_KEY, C.CUSTOMER_ID NULLS LAST, CNTRR NULLS LAST), CT2 AS (SELECT COUNT(PRODUCT_KEY) AS CNT FROM PRODUCT) SELECT CT.CUSTOMER_ID FROM CT CROSS JOIN CT2 WHERE CT.CNTRR = CT2.CNT;

/*
Prediction Result:
(None,)
*/