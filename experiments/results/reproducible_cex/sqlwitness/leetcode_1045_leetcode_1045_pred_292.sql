-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 2), (NULL, 2), (NULL, 0), (NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(0,)
(1,)
(2,)
*/

-- Prediction Query
WITH A1 AS (SELECT CUSTOMER_ID, COUNT(DISTINCT A.PRODUCT_KEY) AS BOUGHT FROM PRODUCT AS A JOIN CUSTOMER AS B ON A.PRODUCT_KEY = B.PRODUCT_KEY GROUP BY 1), A2 AS (SELECT COUNT(*) AS CNT FROM PRODUCT) SELECT CUSTOMER_ID FROM A1 JOIN A2 ON A1.BOUGHT = A2.CNT;

/*
Prediction Result:
*/