-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_key) VALUES (10);
INSERT INTO Product (product_key) VALUES (20);
INSERT INTO Product (product_key) VALUES (30);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 10);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 20);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 10);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 20);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
WITH FIRST_PASS AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS TOTAL_PRODUCTS FROM CUSTOMER WHERE LENGTH(PRODUCT_KEY) > 0 GROUP BY 1) SELECT CUSTOMER_ID FROM FIRST_PASS WHERE TOTAL_PRODUCTS = (SELECT COUNT(DISTINCT PRODUCT_KEY) FROM CUSTOMER);

/*
Prediction Result:
(1,)
(2,)
*/