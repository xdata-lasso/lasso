-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, NULL), (-1, 'default1'), (2, 'B'), (3, 'A'), (4, 'C'), (5, NULL), (6, 'B'), (7, 'B'), (8, 'C'), (9, NULL), (10, 'C'), (11, 'default1'), (12, 'A'), (13, NULL), (14, 'default2'), (15, 'A'), (16, NULL), (17, NULL), (18, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 11, 'default1'), (2, 9, 'default2'), (1, 1, NULL), (-1, -1, 'B'), (3, 10, 'A'), (4, 11, 'A'), (5, 7, 'default1'), (6, 9, 'C'), (7, 16, 'A'), (8, 8, 'default2'), (9, 17, NULL), (10, 12, 'default1'), (11, 11, 'A'), (12, 13, 'C'), (13, 1, 'C'), (14, 16, 'B'), (15, 7, 'C'), (16, 2, 'B'), (17, 8, 'B'), (18, 15, 'default1'), (19, 4, 'B'), (20, 8, 'A'), (21, -1, 'default2'), (22, -1, 'C'), (23, 9, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(8, 'C')
(16, None)
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID AS CUSTOMER_ID, C.CUSTOMER_NAME AS CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(16, None)
(8, 'C')
*/