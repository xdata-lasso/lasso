-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID FROM (SELECT A.CUSTOMER_ID, A.PRODUCT_KEY, COUNT(DISTINCT A.PRODUCT_KEY) AS CNT FROM CUSTOMER AS A INNER JOIN PRODUCT AS B ON A.PRODUCT_KEY = B.PRODUCT_KEY GROUP BY A.CUSTOMER_ID) AS C WHERE C.CNT = (SELECT COUNT(D.PRODUCT_KEY) AS CNT FROM PRODUCT AS D);

/*
Prediction Result:
*/