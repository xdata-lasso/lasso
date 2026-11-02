-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Customer (product_key, customer_id) VALUES (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
*/

-- Prediction Query
WITH TEMP AS (SELECT C.CUSTOMER_ID, C.PRODUCT_KEY AS P1, P.PRODUCT_KEY AS P2 FROM CUSTOMER AS C LEFT JOIN PRODUCT AS P ON C.PRODUCT_KEY = P.PRODUCT_KEY) SELECT CUSTOMER_ID FROM TEMP WHERE P1 = P2 GROUP BY 1 HAVING COUNT(DISTINCT P1) = (SELECT COUNT(DISTINCT PRODUCT_KEY) FROM PRODUCT);

/*
Prediction Result:
*/