-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'default2'), (2, NULL), (-1, 'B'), (3, 'B'), (4, 'default1'), (5, 'C'), (6, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, -1, NULL), (2, NULL, 'B'), (0, 2, NULL), (1, 3, 'default1'), (3, 4, 'default1'), (4, 6, 'C'), (5, 5, 'A'), (6, 0, NULL), (7, NULL, 'C'), (8, 3, NULL), (9, NULL, 'B'), (10, 3, 'B'), (11, -1, 'B'), (12, 1, 'A'), (13, 6, 'default1'), (14, 5, 'default1'), (15, 2, 'default2'), (16, NULL, 'C'), (17, 1, 'A'), (18, NULL, NULL), (19, 0, NULL), (20, 5, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'C')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS OA ON C.CUSTOMER_ID = OA.CUSTOMER_ID JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS OB ON C.CUSTOMER_ID = OB.CUSTOMER_ID WHERE NOT C.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY 1, C.customer_id NULLS LAST;

/*
Prediction Result:
*/