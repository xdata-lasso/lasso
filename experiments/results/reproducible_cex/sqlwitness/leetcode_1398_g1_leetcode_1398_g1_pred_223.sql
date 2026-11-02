-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'default1'), (3, 'default1'), (-1, 'A'), (2, 'B'), (4, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, -1, 'default2'), (-1, 0, 'B'), (0, 3, NULL), (1, NULL, NULL), (3, 2, 'B'), (4, 4, NULL), (5, 1, 'default2'), (6, NULL, 'A'), (7, -1, 'default1'), (8, 2, 'default2'), (9, 1, 'A'), (10, -1, 'default2'), (11, -1, 'C'), (12, 3, 'default2'), (13, 0, 'A'), (14, NULL, 'B'), (15, NULL, 'A'), (16, NULL, 'B'), (17, 2, 'B'), (18, 2, NULL), (19, 3, 'B'), (20, 2, 'default2'), (21, 3, NULL), (22, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'A')
*/

-- Prediction Query
WITH SUBTABLE AS (SELECT CUSTOMER_ID, PRODUCT_NAME FROM ORDERS GROUP BY CUSTOMER_ID, PRODUCT_NAME), TABLE2 AS (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 ELSE 0 END) AS PERSON_VALUE FROM SUBTABLE GROUP BY CUSTOMER_ID) SELECT T.CUSTOMER_ID, C.CUSTOMER_NAME FROM TABLE2 AS T LEFT JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID WHERE PERSON_VALUE = 2;

/*
Prediction Result:
(None, None)
(0, 'A')
*/