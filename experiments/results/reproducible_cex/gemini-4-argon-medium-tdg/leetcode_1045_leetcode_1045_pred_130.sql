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
WITH DISTINCT_CUSTOMER AS (SELECT DISTINCT CUSTOMER_ID, PRODUCT_KEY FROM CUSTOMER), GROUPED_CUSTOMER AS (SELECT CUSTOMER_ID, COUNT(*) AS PRODUCT_COUNT FROM DISTINCT_CUSTOMER GROUP BY CUSTOMER_ID) SELECT CUSTOMER_ID FROM GROUPED_CUSTOMER WHERE PRODUCT_COUNT = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
(101,)
*/