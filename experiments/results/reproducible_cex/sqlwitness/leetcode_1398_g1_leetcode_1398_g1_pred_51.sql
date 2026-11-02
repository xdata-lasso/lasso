-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default1'), (1, 'B'), (0, 'default1'), (-1, 'C'), (3, 'A');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'default1'), (0, NULL, 'C'), (-1, 2, 'B'), (2, NULL, 'A'), (3, 2, 'default1'), (4, NULL, NULL), (5, 0, 'C'), (6, 3, 'default1'), (7, 0, NULL), (8, -1, 'A'), (9, 2, 'default2'), (10, 0, 'default1'), (11, NULL, 'default1'), (12, 1, 'C'), (13, 1, 'default2'), (14, NULL, 'C'), (15, 3, 'C'), (16, 0, 'A'), (17, 0, 'B'), (18, -1, 'B'), (19, 3, 'default2'), (20, NULL, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'C')
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, B.CUSTOMER_NAME FROM ORDERS AS A JOIN CUSTOMERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE PRODUCT_NAME = 'A' AND A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT A.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/