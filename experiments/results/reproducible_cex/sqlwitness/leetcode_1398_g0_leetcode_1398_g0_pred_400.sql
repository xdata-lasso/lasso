-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, '%C%'), (2, 'C'), (3, '%A%'), (4, 'C'), (5, '%B%'), (6, '%C%'), (7, 'default1'), (8, 'B'), (9, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, '%C%'), (2, 6, 'C'), (0, 0, NULL), (3, 6, 'A'), (4, 3, '%B%'), (5, 1, 'C'), (6, 3, 'default1'), (7, 6, 'default1'), (8, 7, 'B'), (9, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH CTE1 AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS CT FROM ORDERS GROUP BY 1), CTE2 AS (SELECT CUSTOMER_ID FROM CTE1 WHERE CT NOT LIKE '%C%' AND CT LIKE '%A%' AND CT LIKE '%B%') SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN CTE2 ON C.CUSTOMER_ID = CTE2.CUSTOMER_ID;

/*
Prediction Result:
(3, '%A%')
*/