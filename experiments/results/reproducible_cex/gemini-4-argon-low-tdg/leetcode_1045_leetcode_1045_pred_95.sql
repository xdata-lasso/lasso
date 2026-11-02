-- Schema DDL
CREATE TABLE "Customer" ("product_key" INTEGER, "customer_id" INTEGER NOT NULL, FOREIGN KEY ("product_key") REFERENCES "Product" ("product_key"));

CREATE TABLE "Product" ("product_key" INTEGER PRIMARY KEY);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Product (product_key) VALUES (10);
INSERT INTO Customer (customer_id, product_key) VALUES (1, NULL);
INSERT INTO Customer (customer_id, product_key) VALUES (2, 10);
INSERT INTO Customer (customer_id, product_key) VALUES (2, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT customer_id FROM customer GROUP BY customer_id HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM product);

/*
Gold Result:
(2,)
*/

-- Prediction Query
WITH ABC AS (SELECT A.CUSTOMER_ID, COUNT(DISTINCT B.PRODUCT_KEY) AS COUNTS FROM CUSTOMER AS A JOIN CUSTOMER AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE B.PRODUCT_KEY IN (SELECT * FROM PRODUCT) AND (A.PRODUCT_KEY <> B.PRODUCT_KEY) GROUP BY 1) SELECT CUSTOMER_ID FROM ABC WHERE COUNTS = (SELECT COUNT(*) FROM PRODUCT);

/*
Prediction Result:
*/