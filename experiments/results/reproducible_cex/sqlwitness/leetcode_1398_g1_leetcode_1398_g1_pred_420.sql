-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (2, 'default1'), (-1, 'C'), (1, 'default2'), (3, 'C'), (4, 'default2'), (5, 'C'), (6, 'default2'), (7, NULL), (8, 'A'), (9, NULL), (10, 'A'), (11, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 6, NULL), (1, 2, NULL), (-1, 5, 'B'), (2, NULL, 'C'), (3, 0, 'A'), (4, 0, NULL), (5, 0, NULL), (6, 8, 'B'), (7, 2, 'B'), (8, NULL, NULL), (9, 4, 'default2'), (10, 8, 'B'), (11, 4, 'A'), (12, 7, 'C'), (13, 9, 'default2'), (14, 1, 'C'), (15, 0, 'B'), (16, -1, NULL), (17, 11, 'B'), (18, 10, 'B'), (19, 3, 'default2'), (20, 5, 'C'), (21, 9, 'B'), (22, 5, 'default1'), (23, 9, 'C'), (24, 1, 'A'), (25, 7, 'default2'), (26, NULL, 'A'), (27, 5, NULL), (28, 5, 'C'), (29, 7, 'default1'), (30, NULL, 'B'), (31, 5, NULL), (32, 1, NULL), (33, 11, NULL), (34, 3, 'default1'), (35, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME IN ('A')) AS A JOIN (SELECT O.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O LEFT JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCT_NAME IN ('B')) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C'));

/*
Prediction Result:
*/