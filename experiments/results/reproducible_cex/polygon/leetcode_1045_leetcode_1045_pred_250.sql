-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 19);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(19,)
*/

-- Prediction Query
WITH TMP AS (SELECT B.CUSTOMER_ID, A.PRODUCT_KEY FROM PRODUCT AS A CROSS JOIN (SELECT DISTINCT CUSTOMER_ID FROM CUSTOMER) AS B) SELECT A.CUSTOMER_ID FROM TMP AS A LEFT JOIN CUSTOMER AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID AND A.PRODUCT_KEY = B.PRODUCT_KEY GROUP BY 1 HAVING COUNT(DISTINCT A.PRODUCT_KEY) = COUNT(DISTINCT B.PRODUCT_KEY);

/*
Prediction Result:
*/