-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Product (product_key) VALUES (-1);
INSERT INTO Product (product_key) VALUES (0);
INSERT INTO Product (product_key) VALUES (2);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 0);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 2);
INSERT INTO Customer (customer_id, product_key) VALUES (2, -1);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 2);
INSERT INTO Customer (customer_id, product_key) VALUES (3, -1);
INSERT INTO Customer (customer_id, product_key) VALUES (3, 0);
INSERT INTO Customer (customer_id, product_key) VALUES (3, 2);
INSERT INTO Customer (customer_id, product_key) VALUES (4, 2);
INSERT INTO Customer (customer_id, product_key) VALUES (4, 2);
INSERT INTO Customer (customer_id, product_key) VALUES (4, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(3,)
*/

-- Prediction Query
WITH TEMP AS (SELECT C.CUSTOMER_ID, P.PRODUCT_KEY FROM CUSTOMER AS C CROSS JOIN PRODUCT AS P) SELECT DISTINCT CUSTOMER_ID FROM CUSTOMER WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT T.CUSTOMER_ID, COALESCE(C.PRODUCT_KEY, 0) AS PK FROM TEMP AS T LEFT JOIN CUSTOMER AS C ON T.CUSTOMER_ID = C.CUSTOMER_ID AND T.PRODUCT_KEY = C.PRODUCT_KEY) AS T1 WHERE PK = 0);

/*
Prediction Result:
*/