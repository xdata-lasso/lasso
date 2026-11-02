-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, NULL, NULL), (-1, NULL, 'C'), (1, NULL, 'default2'), (0, NULL, 'B'), (3, 0, 'B'), (4, NULL, 'B'), (5, 0, 'B'), (6, NULL, NULL), (7, 0, 'B'), (8, NULL, 'A'), (9, 0, 'default2'), (10, NULL, 'default2'), (11, 0, 'default2'), (12, NULL, 'C'), (13, 0, 'default2'), (14, 0, NULL), (15, NULL, NULL), (16, NULL, 'default2'), (17, 0, 'default1'), (18, NULL, 'B'), (19, NULL, 'default1'), (20, 0, 'default1'), (21, NULL, 'C'), (22, NULL, 'A'), (23, NULL, 'C'), (24, 0, 'A'), (25, NULL, 'B'), (26, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, None)
*/

-- Prediction Query
WITH LEFTY AS (SELECT DISTINCT C.CUSTOMER_ID, CUSTOMER_NAME, O.PRODUCT_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' OR O.PRODUCT_NAME = 'B'), RIGHTY AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS AS O WHERE PRODUCT_NAME = 'C') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM LEFTY WHERE NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM RIGHTY) GROUP BY CUSTOMER_ID HAVING COUNT(*) = 2;

/*
Prediction Result:
*/