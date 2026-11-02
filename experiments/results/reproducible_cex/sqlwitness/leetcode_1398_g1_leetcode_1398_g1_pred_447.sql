-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default1'), (0, NULL), (-1, 'C'), (1, 'default2'), (3, 'C'), (4, NULL), (5, 'default2'), (6, 'B'), (7, 'C'), (8, 'A'), (9, 'A'), (10, 'default1'), (11, 'B'), (12, 'default1'), (13, 'B'), (14, 'default2'), (15, 'A'), (16, 'default2'), (17, 'B'), (18, 'C'), (19, NULL), (20, 'C'), (21, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'C'), (0, NULL, 'C'), (1, 2, 'default2'), (2, 16, NULL), (3, 15, 'B'), (4, 5, 'default2'), (5, 4, 'B'), (6, 5, NULL), (7, 13, 'A'), (8, NULL, NULL), (9, 4, 'B'), (10, 8, 'A'), (11, -1, 'default1'), (12, 17, 'C'), (13, 16, 'A'), (14, 9, 'A'), (15, 18, 'B'), (16, 7, 'A'), (17, 21, 'C'), (18, -1, 'C'), (19, 17, 'C'), (20, NULL, 'A'), (21, 4, 'default2'), (22, 9, 'B'), (23, 17, 'B'), (24, 3, 'C'), (25, 7, 'default1'), (26, 20, 'default2'), (27, -1, 'C'), (28, 5, 'C'), (29, 7, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(9, 'A')
*/

-- Prediction Query
WITH PRODUCT_A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), PRODUCT_B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), PRODUCT_C AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') SELECT * FROM CUSTOMERS AS C WHERE CUSTOMER_ID IN (SELECT * FROM PRODUCT_A) AND CUSTOMER_ID IN (SELECT * FROM PRODUCT_B) AND NOT CUSTOMER_ID IN (SELECT * FROM PRODUCT_C);

/*
Prediction Result:
*/