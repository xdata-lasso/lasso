-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Product (product_key) VALUES (100);
INSERT INTO Product (product_key) VALUES (200);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 100);
INSERT INTO Customer (customer_id, product_key) VALUES (1, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 100);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 200);
INSERT INTO Customer (customer_id, product_key) VALUES (2, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (3, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(2,)
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, DENSE_RANK() OVER (PARTITION BY CUSTOMER_ID ORDER BY PRODUCT_KEY) AS NUMBER FROM CUSTOMER) AS N WHERE NUMBER = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(1,)
(2,)
*/