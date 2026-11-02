-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (0, 'B'), (1, 'B'), (2, 'A'), (3, 'default2'), (4, 'C'), (5, 'B'), (6, NULL), (7, 'B'), (8, 'A'), (9, 'C'), (10, 'default1'), (11, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 3, 'C'), (1, 4, 'default2'), (2, 8, 'default2'), (0, 7, 'C'), (3, 0, 'B'), (4, NULL, 'C'), (5, 7, 'B'), (6, 4, NULL), (7, -1, 'A'), (8, 1, 'default1'), (9, 5, 'A'), (10, 5, 'B'), (11, 10, 'B'), (12, 6, 'C'), (13, 5, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'B')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/