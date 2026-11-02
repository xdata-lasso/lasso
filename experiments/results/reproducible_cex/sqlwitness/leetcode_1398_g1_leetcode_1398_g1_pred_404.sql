-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (2, 'A'), (0, 'default2'), (-1, 'default2'), (3, 'default2'), (4, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'B'), (2, 1, NULL), (-1, 2, 'default1'), (1, 1, 'C'), (3, 0, 'default2'), (4, 2, 'B'), (5, -1, 'B'), (6, NULL, 'C'), (7, 2, 'A'), (8, 4, NULL), (9, 3, 'default2'), (10, 0, 'default2'), (11, 3, 'B'), (12, NULL, NULL), (13, NULL, 'default2'), (14, 3, 'default2'), (15, -1, 'A'), (16, 3, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'default2')
(2, 'A')
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'C');

/*
Prediction Result:
*/