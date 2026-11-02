-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Product (product_key) VALUES (1);
INSERT INTO Product (product_key) VALUES (2);
INSERT INTO Customer (product_key, customer_id) VALUES (2, 1);
INSERT INTO Customer (product_key, customer_id) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID AS CUSTOMER_ID FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT (PRODUCT_KEY)) AS NEW FROM CUSTOMER GROUP BY CUSTOMER_ID) AS A WHERE NEW = (SELECT GROUP_CONCAT(DISTINCT (PRODUCT_KEY)) FROM PRODUCT);

/*
Prediction Result:
*/