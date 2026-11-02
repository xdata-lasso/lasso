-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 15);
INSERT INTO "Customer" ("product_key", "customer_id") VALUES (NULL, 14);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(14,)
(15,)
*/

-- Prediction Query
SELECT T.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM CUSTOMER AS C INNER JOIN PRODUCT AS P ON C.PRODUCT_KEY = P.PRODUCT_KEY GROUP BY 1 HAVING COUNT(DISTINCT C.PRODUCT_KEY) = (SELECT COUNT(1) FROM PRODUCT)) AS T;

/*
Prediction Result:
*/