-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default1'), (2, 'default1'), (1, 'C'), (-1, 'default2'), (3, NULL), (4, 'default2'), (5, 'C'), (6, NULL), (7, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 2, 'A'), (-1, 4, NULL), (0, 0, 'B'), (1, 2, 'default2'), (3, 5, 'A'), (4, 4, 'A'), (5, 3, 'default2'), (6, NULL, NULL), (7, 5, 'default2'), (8, 7, 'B'), (9, -1, NULL), (10, 0, 'B'), (11, NULL, NULL), (12, 7, 'B'), (13, 5, 'default1'), (14, 2, 'default2'), (15, 1, 'A'), (16, 6, 'default1'), (17, 7, 'C'), (18, 0, 'default1'), (19, 6, 'default1'), (20, 1, 'B'), (21, -1, NULL), (22, 7, NULL), (23, 2, 'default1'), (24, 4, NULL), (25, 7, NULL), (26, 4, 'default1'), (27, 5, 'B'), (28, 6, 'default2'), (29, NULL, 'A'), (30, -1, 'default1'), (31, 0, 'default1'), (32, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'C')
(5, 'C')
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE (O.CUSTOMER_ID, 'A') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (O.CUSTOMER_ID, 'B') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (O.CUSTOMER_ID, 'C') IN (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS);

/*
Prediction Result:
*/