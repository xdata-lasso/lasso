-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, NULL), (-1, '%C%'), (0, '%C%'), (2, '%A%'), (3, '%A%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 3, 'default2'), (-1, -1, 'B'), (0, 0, '%C%'), (1, 0, 'default2'), (3, 2, '%B%'), (4, NULL, 'default2'), (5, 2, NULL), (6, 1, 'default2'), (7, 2, 'B'), (8, -1, '%A%'), (9, 1, 'A'), (10, NULL, '%A%'), (11, 2, 'default2'), (12, 3, 'C'), (13, 3, 'default1'), (14, 0, 'C'), (15, 1, '%B%'), (16, 1, '%A%'), (17, 0, '%C%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS NAME FROM ORDERS GROUP BY CUSTOMER_ID) AS A WHERE NAME LIKE '%A%' AND NAME LIKE '%B%' AND NAME NOT LIKE '%C%') ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(-1, '%C%')
(1, None)
(2, '%A%')
*/