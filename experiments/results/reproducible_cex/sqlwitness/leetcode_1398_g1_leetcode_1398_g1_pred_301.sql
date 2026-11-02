-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (-1, 'default1'), (2, 'A'), (3, NULL), (0, 'B'), (4, 'C'), (5, 'A'), (6, 'B'), (7, NULL), (8, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 4, 'default2'), (1, 1, NULL), (0, 4, 'B'), (3, 0, 'default1'), (-1, 2, NULL), (4, 4, 'default2'), (5, 8, 'A'), (6, 7, NULL), (7, 7, 'default2'), (8, NULL, NULL), (9, 2, 'C'), (10, 0, 'default2'), (11, 2, 'B'), (12, 6, 'A'), (13, 2, 'B'), (14, 4, NULL), (15, 1, NULL), (16, NULL, 'default1'), (17, 6, 'A'), (18, 3, 'A'), (19, 1, 'default2'), (20, -1, 'A'), (21, -1, 'default1'), (22, 6, 'A'), (23, 2, 'C'), (24, 0, 'default2'), (25, 4, NULL), (26, 2, 'A'), (27, 4, 'A'), (28, 7, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'C')
*/

-- Prediction Query
SELECT T3.* FROM (SELECT T1.CUSTOMER_ID, CNT1, CNT2 FROM (SELECT CUSTOMER_ID, COUNT(DISTINCT ORDER_ID) AS CNT1 FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID) AS T1 LEFT JOIN (SELECT CUSTOMER_ID, COUNT(DISTINCT ORDER_ID) AS CNT2 FROM ORDERS WHERE PRODUCT_NAME IN ('C') GROUP BY CUSTOMER_ID) AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID WHERE CNT1 >= 2) AS T INNER JOIN (SELECT * FROM CUSTOMERS) AS T3 ON T.CUSTOMER_ID = T3.CUSTOMER_ID WHERE CNT2 IS NULL;

/*
Prediction Result:
(4, 'C')
(6, 'B')
*/