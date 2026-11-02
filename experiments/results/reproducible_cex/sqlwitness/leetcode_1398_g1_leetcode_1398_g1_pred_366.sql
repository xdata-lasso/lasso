-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'A'), (3, 'default2'), (2, 'C'), (0, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, 'default1'), (-1, 3, 'B'), (0, 2, 'default1'), (1, -1, 'A'), (3, 2, 'B'), (4, 2, NULL), (5, -1, NULL), (6, 3, 'C'), (7, 2, NULL), (8, NULL, 'B'), (9, NULL, NULL), (10, 0, 'default2'), (11, 0, NULL), (12, NULL, 'A'), (13, NULL, 'A'), (14, 2, 'A'), (15, NULL, 'default1'), (16, 3, 'B'), (17, -1, NULL), (18, NULL, 'C'), (19, -1, 'B'), (20, NULL, 'C'), (21, 0, 'A'), (22, NULL, 'C'), (23, 0, 'default2'), (24, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'A')
(2, 'C')
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT C.CUSTOMER_ID FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID WHERE O.PRODUCT_NAME = 'A' OR O.PRODUCT_NAME = 'B' GROUP BY 1 HAVING COUNT(DISTINCT O.PRODUCT_NAME) = 2 AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C')) ORDER BY 1, CUSTOMERS.customer_id NULLS LAST;

/*
Prediction Result:
*/