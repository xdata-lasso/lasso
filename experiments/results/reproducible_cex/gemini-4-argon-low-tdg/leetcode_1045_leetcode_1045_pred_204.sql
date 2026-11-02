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
WITH PRODCNT AS (SELECT COUNT(PRODUCT_KEY) AS PRODS FROM PRODUCT), CUSTCNT AS (SELECT CUSTOMER_ID, COUNT(DISTINCT PRODUCT_KEY) AS PRODUCTS FROM CUSTOMER JOIN PRODUCT USING (PRODUCT_KEY) GROUP BY 1) SELECT CUSTOMER_ID FROM CUSTCNT WHERE PRODUCTS = (SELECT PRODS FROM PRODCNT);

/*
Prediction Result:
*/