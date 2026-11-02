-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (-1, 'default2'), (2, 'default1'), (0, 'B'), (3, 'A'), (4, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, NULL), (0, 4, 'B'), (2, NULL, 'B'), (-1, 0, 'default1'), (3, 2, 'default2'), (4, 2, 'default2'), (5, 0, 'B'), (6, 4, 'default2'), (7, 1, 'default2'), (8, 2, NULL), (9, 2, 'C'), (10, 0, NULL), (11, NULL, 'C'), (12, 2, 'C'), (13, 4, 'A'), (14, 4, 'default2'), (15, 4, 'default1'), (16, 0, 'default1'), (17, 1, 'C'), (18, 3, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'default1')
*/

-- Prediction Query
SELECT DISTINCT SUB.A AS CUSTOMER_ID, SUB.B AS CUSTOMER_NAME FROM (SELECT O.CUSTOMER_ID AS A, C.CUSTOMER_NAME AS B, O.PRODUCT_NAME AS C FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE C.CUSTOMER_ID IN (SELECT O1.CUSTOMER_ID FROM (SELECT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'A') AS O1 JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AS T1 ON O1.CUSTOMER_ID = T1.CUSTOMER_ID) AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) AS SUB;

/*
Prediction Result:
*/