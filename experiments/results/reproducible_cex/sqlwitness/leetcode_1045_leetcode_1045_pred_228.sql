-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_key) VALUES (1), (0), (2), (3), (4);
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 0), (4, 0), (NULL, 1), (2, 0), (3, 0), (1, 1), (3, 1), (NULL, 1), (3, 0), (0, 1), (2, 1), (2, 0), (4, 0), (2, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
WITH DENSERANK AS (SELECT *, DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY PRODUCT_KEY) AS RNK FROM CUSTOMER) SELECT DISTINCT CUSTOMER_ID FROM DENSERANK WHERE RNK = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(1,)
*/