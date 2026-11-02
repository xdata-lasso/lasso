-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (0, 'default1'), (-1, 'default2'), (1, 'A'), (3, 'B'), (4, 'B'), (5, NULL), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 3, 'default1'), (0, 6, 'B'), (2, 1, 'A'), (1, 2, 'default1'), (3, 0, NULL), (4, 5, 'default1'), (5, NULL, 'default2'), (6, 1, 'A'), (7, 1, 'B'), (8, 3, 'B'), (9, 2, NULL), (10, 2, 'C'), (11, -1, 'B'), (12, 3, 'default2'), (13, -1, NULL), (14, -1, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'A')
*/

-- Prediction Query
SELECT SUB1.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AS SUB1 JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS SUB2 ON SUB1.CUSTOMER_ID = SUB2.CUSTOMER_ID LEFT JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AS SUB3 ON SUB1.CUSTOMER_ID = SUB3.CUSTOMER_ID JOIN CUSTOMERS AS C ON SUB1.CUSTOMER_ID = C.CUSTOMER_ID WHERE SUB3.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(1, 'A')
(1, 'A')
*/