-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO Customer (customer_id, product_key) VALUES (1, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (2, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(1,)
(2,)
*/

-- Prediction Query
SELECT A.CUSTOMER_ID FROM (SELECT CUSTOMER_ID, SUM(DISTINCT PRODUCT_KEY) AS TOTAL1 FROM CUSTOMER GROUP BY CUSTOMER_ID) AS A CROSS JOIN (SELECT SUM(DISTINCT PRODUCT_KEY) AS TOTAL2 FROM PRODUCT) AS B WHERE A.TOTAL1 = B.TOTAL2;

/*
Prediction Result:
*/