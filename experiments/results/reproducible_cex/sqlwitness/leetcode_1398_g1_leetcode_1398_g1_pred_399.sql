-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (-1, NULL), (0, 'default2'), (2, NULL), (3, 'default1'), (4, 'default1'), (5, NULL), (6, 'C'), (7, NULL), (8, 'B'), (9, 'C'), (10, 'B'), (11, 'C'), (12, 'B'), (13, 'default1'), (14, 'A'), (15, 'default1'), (16, 'C'), (17, 'default2'), (18, 'B'), (19, 'A'), (20, 'default1'), (21, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 13, 'B'), (2, 6, NULL), (0, 3, 'default1'), (1, 6, 'A'), (3, 4, 'A'), (4, 8, 'B'), (5, 4, 'A'), (6, 13, 'default2'), (7, 6, 'B'), (8, 21, 'default1'), (9, 4, 'C'), (10, 3, 'C'), (11, 9, 'default2'), (12, 14, 'C'), (13, 18, 'default1'), (14, 0, NULL), (15, -1, 'default1'), (16, 18, 'B'), (17, 14, 'default2'), (18, 5, 'A'), (19, 3, 'B'), (20, 7, 'default2'), (21, 11, 'C'), (22, -1, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'C')
*/

-- Prediction Query
SELECT DISTINCT O.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID WHERE (O.CUSTOMER_ID, 'A') IN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND (O.CUSTOMER_ID, 'B') IN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS) AND NOT (O.CUSTOMER_ID, 'C') IN (SELECT DISTINCT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS);

/*
Prediction Result:
*/