-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'C'), (-1, 'A'), (1, NULL), (0, 'B'), (3, 'A'), (4, 'default1'), (5, 'A'), (6, NULL), (7, 'C'), (8, NULL), (9, 'C'), (10, 'default2'), (11, 'default2'), (12, NULL), (13, 'B'), (14, 'B'), (15, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 3, 'default2'), (0, 13, 'B'), (-1, 3, 'default1'), (2, 1, 'A'), (3, 3, 'C'), (4, 3, 'C'), (5, 6, 'C'), (6, 9, 'B'), (7, 2, 'B'), (8, 2, 'C'), (9, 5, 'default1'), (10, NULL, 'C'), (11, 4, 'A'), (12, 15, 'C'), (13, 13, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(13, 'B')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT O.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/