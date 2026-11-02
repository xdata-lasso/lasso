-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (0, NULL), (1, 'B'), (2, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'default1'), (1, 0, NULL), (0, -1, 'default2'), (2, -1, 'A'), (3, NULL, NULL), (4, NULL, NULL), (5, 0, NULL), (6, NULL, 'default2'), (7, 2, 'default1'), (8, NULL, 'C'), (9, NULL, NULL), (10, -1, 'A'), (11, 0, 'B'), (12, -1, 'default2'), (13, -1, 'default1'), (14, 2, 'A'), (15, 1, 'B'), (16, 0, 'C'), (17, 0, 'A'), (18, -1, 'C'), (19, 1, 'B'), (20, -1, 'C'), (21, -1, 'A'), (22, 2, NULL), (23, 2, 'default2'), (24, -1, 'C'), (25, 2, 'B'), (26, -1, NULL), (27, 2, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT DISTINCT O1.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS AS O1 JOIN CUSTOMERS AS C USING (CUSTOMER_ID) JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' WHERE NOT O1.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/