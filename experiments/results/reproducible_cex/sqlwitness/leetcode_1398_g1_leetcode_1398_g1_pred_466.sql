-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'default1'), (0, 'default2'), (2, 'C'), (1, NULL), (3, 'C'), (4, 'default2'), (5, 'default1'), (6, 'B'), (7, 'B'), (8, 'default2'), (9, 'default2'), (10, 'default1'), (11, NULL), (12, 'A'), (13, NULL), (14, 'B'), (15, 'A'), (16, 'B'), (17, 'C'), (18, 'A'), (19, 'A'), (20, NULL), (21, 'default2'), (22, 'default1'), (23, NULL), (24, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 16, 'default1'), (2, 5, 'B'), (1, 14, 'A'), (0, 21, NULL), (3, 11, 'A'), (4, 5, 'A'), (5, 12, 'C'), (6, 8, 'default2'), (7, 9, 'default2'), (8, NULL, 'default2'), (9, 4, 'C'), (10, 3, NULL), (11, 7, 'B'), (12, 6, 'C'), (13, 20, NULL), (14, 7, NULL), (15, 15, 'C'), (16, NULL, 'C'), (17, 11, NULL), (18, 24, 'C'), (19, 19, 'C'), (20, 4, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'default1')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, CUSTOMER_NAME, COUNT(DISTINCT PRODUCT_NAME) AS CNT FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID, CUSTOMER_NAME HAVING CNT > 1) AS T WHERE NOT T.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/