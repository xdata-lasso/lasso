-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO product (product_key) VALUES (0), (1), (2);
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 0), (NULL, 1), (NULL, 1), (1, 0), (1, 1), (NULL, 0), (NULL, 0), (1, 1), (NULL, 0), (0, 1), (2, 1), (2, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER GROUP BY CUSTOMER_ID, PRODUCT_KEY) AS X GROUP BY CUSTOMER_ID HAVING COUNT(*) = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
*/