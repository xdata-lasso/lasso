-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (2, 'B'), (0, 'C'), (-1, NULL), (3, 'default1'), (4, 'default2'), (5, 'default1'), (6, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 0, 'A'), (2, 4, NULL), (0, 3, 'B'), (1, 4, 'default1'), (3, 4, 'B'), (4, 5, 'default1'), (5, NULL, 'C'), (6, 1, 'default2'), (7, 1, 'B'), (8, 2, NULL), (9, 0, 'B'), (10, -1, 'A'), (11, 6, 'B'), (12, 2, 'C'), (13, 1, 'default2'), (14, -1, 'default2'), (15, 0, 'default2'), (16, 4, 'C'), (17, 5, 'B'), (18, 6, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'C')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O CROSS JOIN CUSTOMERS AS C WHERE C.CUSTOMER_ID = O.CUSTOMER_ID AND O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY O.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/