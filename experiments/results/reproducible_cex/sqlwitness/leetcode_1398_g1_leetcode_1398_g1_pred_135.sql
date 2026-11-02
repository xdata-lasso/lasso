-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, NULL), (0, 'default1'), (-1, NULL), (1, 'C'), (2, 'default2'), (4, 'B'), (5, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, NULL, 'C'), (1, -1, 'default1'), (-1, 5, 'A'), (0, 5, 'B'), (3, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(5, 'default1')
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE (PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY C.CUSTOMER_ID, CUSTOMER_NAME HAVING COUNT(CUSTOMER_NAME) = 2 ORDER BY C.CUSTOMER_ID, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/