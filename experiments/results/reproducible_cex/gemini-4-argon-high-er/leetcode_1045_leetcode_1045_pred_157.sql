-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO Product (product_key) VALUES (0);
INSERT INTO Product (product_key) VALUES (1);
INSERT INTO Customer (customer_id, product_key) VALUES (1, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, SUM(DISTINCT PRODUCT_KEY) AS PRD_SUM FROM CUSTOMER GROUP BY CUSTOMER_ID) AS TMP WHERE PRD_SUM = (SELECT SUM(PRODUCT_KEY) FROM PRODUCT);

/*
Prediction Result:
(1,)
*/