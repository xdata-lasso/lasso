-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (3, 'A'), (1, NULL), (-1, 'C'), (2, 'default1'), (4, 'default2'), (5, NULL), (6, 'A'), (7, 'A'), (8, NULL), (9, 'C'), (10, 'A'), (11, 'C'), (12, 'B'), (13, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, -1, 'default1'), (2, 9, 'C'), (-1, 9, NULL), (0, 10, 'A'), (3, 7, 'C'), (4, NULL, NULL), (5, 12, 'default1'), (6, 3, NULL), (7, 9, 'C'), (8, 3, NULL), (9, 3, 'A'), (10, 9, 'B'), (11, 12, NULL), (12, 0, 'B'), (13, 13, 'C'), (14, 3, 'B'), (15, 7, 'B'), (16, 7, 'C'), (17, 12, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'A')
*/

-- Prediction Query
WITH CTE AS (SELECT Z.CUSTOMER_ID FROM (SELECT O.CUSTOMER_ID, COUNT(*) AS CC FROM ORDERS AS O GROUP BY O.CUSTOMER_ID) AS Z WHERE Z.CC < 2), CTE1 AS (SELECT O.CUSTOMER_ID FROM ORDERS AS O WHERE O.PRODUCT_NAME = 'C') SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C WHERE NOT C.CUSTOMER_ID IN (SELECT * FROM CTE) AND NOT C.CUSTOMER_ID IN (SELECT * FROM CTE1) AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B');

/*
Prediction Result:
*/