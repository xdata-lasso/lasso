-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, 'default2'), (-1, 'A'), (2, 'default1'), (3, 'default1'), (4, 'B'), (5, 'default2'), (6, 'C'), (7, 'B'), (8, NULL), (9, 'default2'), (10, 'B'), (11, 'default1'), (12, 'A'), (13, 'default2'), (14, 'B'), (15, 'A'), (16, 'default2'), (17, 'C'), (18, NULL), (19, 'A'), (20, 'A'), (21, NULL), (22, 'A'), (23, 'A'), (24, 'B'), (25, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 1, 'default2'), (-1, 11, 'C'), (1, 8, 'default2'), (2, 7, 'default2'), (3, 13, 'A'), (4, 13, 'default1'), (5, 10, 'B'), (6, 6, 'A'), (7, 6, 'B'), (8, -1, 'A'), (9, 23, 'A'), (10, 17, 'default2'), (11, 12, 'default2'), (12, 17, 'B'), (13, 19, 'default2'), (14, 21, 'default2'), (15, 10, 'default2'), (16, 0, 'A'), (17, 9, 'B'), (18, 25, 'C'), (19, 17, 'C'), (20, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, 'C')
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B')) AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
*/