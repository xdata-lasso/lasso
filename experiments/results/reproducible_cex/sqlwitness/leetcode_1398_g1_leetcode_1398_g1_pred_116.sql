-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (2, NULL), (1, 'A'), (-1, NULL), (3, 'C'), (4, NULL), (5, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 5, 'default2'), (-1, 3, 'default1'), (0, 1, 'A'), (1, 5, 'B'), (3, 1, 'default2'), (4, 2, 'B'), (5, 4, 'C'), (6, -1, 'default2'), (7, 1, 'C'), (8, 4, 'default2'), (9, 0, 'default2'), (10, NULL, 'B'), (11, 2, 'B'), (12, 4, 'default1'), (13, 2, 'B'), (14, 5, 'C'), (15, NULL, 'A'), (16, NULL, NULL), (17, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT B.CUSTOMER_ID, B.CUSTOMER_NAME FROM (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME, SUM(CASE WHEN A.PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS PRODUCTA, SUM(CASE WHEN A.PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS PRODUCTB, SUM(CASE WHEN A.PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS PRODUCTC FROM (SELECT ORDERS.CUSTOMER_ID, ORDERS.PRODUCT_NAME, CUSTOMERS.CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID) AS A GROUP BY A.CUSTOMER_ID, A.CUSTOMER_NAME) AS B WHERE B.PRODUCTA > 0 AND B.PRODUCTB > 0 AND B.PRODUCTC = 0;

/*
Prediction Result:
(None, None)
*/