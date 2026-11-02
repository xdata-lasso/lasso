-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (2, 'B'), (1, 'C'), (0, 'default1'), (3, 'A'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'C'), (8, 'default2'), (9, 'A'), (10, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 7, NULL), (-1, 0, 'default2'), (2, 10, 'C'), (0, 8, NULL), (3, 8, 'A'), (4, 5, NULL), (5, 1, 'default2'), (6, 9, NULL), (7, 10, 'default2'), (8, NULL, 'default1'), (9, 1, 'A'), (10, 9, 'B'), (11, -1, NULL), (12, 5, 'B'), (13, 4, 'default2'), (14, 2, 'default2'), (15, -1, 'default1'), (16, 4, 'B'), (17, 8, 'default1'), (18, 2, 'default1'), (19, 4, 'A'), (20, 0, NULL), (21, 5, 'default1'), (22, 0, 'default1'), (23, NULL, 'C'), (24, NULL, 'A'), (25, 7, 'default2'), (26, 2, 'B'), (27, 7, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
WITH C AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C'), A AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') SELECT DISTINCT CUSTOMERS.CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = ORDERS.CUSTOMER_ID WHERE NOT CUSTOMERS.CUSTOMER_ID IN (SELECT * FROM C) AND CUSTOMERS.CUSTOMER_ID IN (SELECT * FROM A) AND CUSTOMERS.CUSTOMER_ID IN (SELECT * FROM B) ORDER BY 1, CUSTOMERS.CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/