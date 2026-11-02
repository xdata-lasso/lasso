-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'C'), (1, 'default1'), (0, 'default1'), (2, 'default2'), (4, 'default2'), (5, NULL), (6, 'A'), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, NULL), (2, 0, 'B'), (1, NULL, 'default2'), (3, 0, 'A'), (4, 0, 'A'), (5, 6, NULL), (6, 4, 'C'), (7, 2, 'A'), (8, 7, 'default2'), (9, 2, 'default2'), (10, 7, 'C'), (11, 6, 'A'), (12, 1, 'default1'), (13, 6, 'default2'), (14, 4, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default1')
*/

-- Prediction Query
WITH CTE AS (SELECT ORDER_ID, CUSTOMER_ID, PRODUCT_NAME FROM ORDERS WHERE PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B'), CTE2 AS (SELECT CUSTOMER_ID, COUNT(PRODUCT_NAME) AS N FROM CTE GROUP BY 1), CTE3 AS (SELECT CUSTOMER_ID FROM CTE2 WHERE N = 2), CTE4 AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE3) AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM CTE4);

/*
Prediction Result:
*/