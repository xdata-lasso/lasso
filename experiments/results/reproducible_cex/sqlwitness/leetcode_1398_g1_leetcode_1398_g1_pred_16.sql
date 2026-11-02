-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'C'), (1, 'C'), (-1, NULL), (2, NULL), (3, 'C'), (4, 'A'), (5, 'A'), (6, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 4, 'default1'), (0, 3, NULL), (-1, NULL, 'default1'), (1, NULL, NULL), (3, 2, 'B'), (4, NULL, NULL), (5, NULL, 'A'), (6, NULL, 'C'), (7, NULL, 'default2'), (8, 3, 'default1'), (9, 3, NULL), (10, 1, NULL), (11, 5, 'B'), (12, 0, 'default2'), (13, 5, 'default2'), (14, 0, 'B'), (15, 6, 'B'), (16, 5, 'A'), (17, 6, 'A'), (18, 5, NULL), (19, 4, 'A'), (20, -1, NULL), (21, 1, NULL), (22, 2, 'B'), (23, -1, 'default1'), (24, NULL, NULL), (25, 4, 'B'), (26, 5, 'C'), (27, 3, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(4, 'A')
(6, 'default1')
*/

-- Prediction Query
SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS LEFT JOIN CUSTOMERS USING (CUSTOMER_ID) WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/