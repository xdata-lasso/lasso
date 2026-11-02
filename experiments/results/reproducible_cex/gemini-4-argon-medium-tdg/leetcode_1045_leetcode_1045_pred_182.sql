-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO Product (product_key) VALUES (1);
INSERT INTO Product (product_key) VALUES (2);
INSERT INTO Customer (customer_id, product_key) VALUES (101, 1);
INSERT INTO Customer (customer_id, product_key) VALUES (101, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (102, 1);
INSERT INTO Customer (customer_id, product_key) VALUES (102, 2);
INSERT INTO Customer (customer_id, product_key) VALUES (102, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(102,)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID FROM (SELECT B.CUSTOMER_ID, COUNT(*) FROM (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER) AS B GROUP BY 1 HAVING COUNT(*) = (SELECT COUNT(*) FROM PRODUCT)) AS A;

/*
Prediction Result:
(101,)
*/