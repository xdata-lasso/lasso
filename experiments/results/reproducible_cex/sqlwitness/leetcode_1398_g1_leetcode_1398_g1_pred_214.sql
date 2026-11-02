-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'A'), (-1, 0, 'B'), (2, NULL, 'default2'), (0, NULL, 'C'), (3, NULL, 'C'), (4, 0, 'B'), (5, 1, 'C'), (6, 0, 'default1'), (7, 0, NULL), (8, 1, NULL), (9, NULL, 'default2'), (10, 0, 'A'), (11, NULL, 'default2'), (12, 0, NULL), (13, 1, 'default1'), (14, NULL, NULL), (15, 0, 'A'), (16, 0, 'default2'), (17, 0, 'default2'), (18, NULL, NULL), (19, 0, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'default1')
*/

-- Prediction Query
WITH CUST_A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), CUST_B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT CUST_A.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUST_A INNER JOIN CUST_B ON CUST_A.CUSTOMER_ID = CUST_B.CUSTOMER_ID INNER JOIN CUSTOMERS AS C ON CUST_A.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT CUST_A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/