-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customer (product_key, customer_id) VALUES (NULL, 2), (NULL, 1), (NULL, 0), (NULL, 2), (NULL, 0), (NULL, 2), (NULL, 2), (NULL, 0), (NULL, 2), (NULL, 2), (NULL, 0), (NULL, 0), (NULL, 0), (NULL, 2), (NULL, 1), (NULL, 2), (NULL, 2), (NULL, 2), (NULL, 0);
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
SELECT CUSTOMER_ID FROM CUSTOMER AS C LEFT JOIN PRODUCT AS P ON C.PRODUCT_KEY = P.PRODUCT_KEY WHERE P.PRODUCT_KEY IN (SELECT DISTINCT C.PRODUCT_KEY FROM CUSTOMER) GROUP BY 1 HAVING COUNT(DISTINCT C.PRODUCT_KEY) = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
*/