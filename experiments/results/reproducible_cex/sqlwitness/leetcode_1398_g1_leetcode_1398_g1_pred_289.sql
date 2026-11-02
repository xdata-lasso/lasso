-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, NULL), (1, 'default1'), (2, NULL), (0, NULL), (3, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, 'default2'), (0, 1, NULL), (1, 3, 'B'), (2, NULL, 'default1'), (3, 3, 'C'), (4, NULL, 'C'), (5, 0, 'default2'), (6, 3, 'A'), (7, 3, 'A'), (8, -1, 'B'), (9, 1, 'default2'), (10, 0, 'B'), (11, NULL, 'B'), (12, 2, 'A'), (13, 1, 'B'), (14, 0, 'default2'), (15, 3, 'default2'), (16, 0, 'A'), (17, NULL, NULL), (18, 0, 'default2'), (19, NULL, NULL), (20, 2, NULL), (21, 1, NULL), (22, 3, 'B'), (23, 0, 'C'), (24, 3, 'default1'), (25, -1, 'default1'), (26, NULL, 'C'), (27, 1, NULL), (28, 3, 'C'), (29, NULL, 'A'), (30, -1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, None)
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT O.CUSTOMER_ID FROM ORDERS AS O JOIN ORDERS AS R ON O.CUSTOMER_ID = R.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' AND R.PRODUCT_NAME = 'B' AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'));

/*
Prediction Result:
*/