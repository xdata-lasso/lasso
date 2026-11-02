-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (3, 'C'), (0, 'B'), (1, NULL), (2, 'C'), (4, 'B'), (5, 'B'), (6, 'A'), (7, 'C'), (8, NULL), (9, 'default2'), (10, 'default2'), (11, NULL), (12, 'default1'), (13, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 6, 'default2'), (0, 13, 'default1'), (3, 13, 'default2'), (1, 12, NULL), (-1, 8, NULL), (4, 2, 'C'), (5, 2, 'B'), (6, 9, NULL), (7, 9, 'A'), (8, 1, 'C'), (9, 0, 'default2'), (10, 12, 'default2'), (11, 3, 'B'), (12, 6, NULL), (13, 7, NULL), (14, 8, 'B'), (15, -1, NULL), (16, 12, 'B'), (17, 3, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' OR O.PRODUCT_NAME = 'B' GROUP BY O.CUSTOMER_ID HAVING COUNT(O.PRODUCT_NAME) = 2 AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(3, 'C')
*/