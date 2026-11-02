-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (2, 'A'), (0, 'A'), (-1, 'A'), (3, 'B'), (4, 'default2'), (5, NULL), (6, 'B'), (7, NULL), (8, 'A'), (9, 'A'), (10, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 8, 'A'), (0, 2, 'C'), (-1, 1, 'default2'), (2, NULL, NULL), (3, 1, 'B'), (4, 8, 'default1'), (5, 2, 'default2'), (6, 0, NULL), (7, 0, NULL), (8, 2, 'B'), (9, NULL, 'B'), (10, 7, 'default2'), (11, NULL, 'default1'), (12, 9, 'default1'), (13, 0, 'default2'), (14, -1, 'B'), (15, 0, 'B'), (16, 0, 'default1'), (17, -1, 'B'), (18, 8, NULL), (19, 0, NULL), (20, 1, 'B'), (21, 3, 'default1'), (22, 4, NULL), (23, 7, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS TOT FROM ORDERS GROUP BY CUSTOMER_ID HAVING TOT > 1) AS O ON TRUE WHERE C.CUSTOMER_ID = O.CUSTOMER_ID;

/*
Prediction Result:
(-1, 'A')
(1, 'A')
*/