-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, NULL), (-1, 'C'), (1, 'C'), (0, 'default1'), (3, 'A'), (4, 'default2'), (5, 'default1'), (6, 'B'), (7, 'default2'), (8, 'A'), (9, 'default1'), (10, 'default2'), (11, NULL), (12, 'C'), (13, 'C'), (14, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'default1'), (-1, 0, 'default1'), (0, NULL, 'C'), (2, 13, 'B'), (3, 5, 'default1'), (4, 9, 'default2'), (5, NULL, 'default1'), (6, 8, 'A'), (7, 12, 'B'), (8, 11, 'B'), (9, 9, 'B'), (10, 5, 'default1'), (11, 9, 'default2'), (12, 4, NULL), (13, NULL, 'default1'), (14, 6, NULL), (15, 0, 'C'), (16, 1, 'default1'), (17, 6, 'C'), (18, 13, 'C'), (19, NULL, 'default2'), (20, 3, 'A'), (21, 1, 'C'), (22, 3, 'default1'), (23, 11, 'default2'), (24, 13, 'A'), (25, 7, 'B'), (26, 4, 'default2'), (27, 9, 'C'), (28, 7, 'C'), (29, 6, NULL), (30, 1, 'default2'), (31, 0, 'default2'), (32, 8, NULL), (33, 7, 'default1'), (34, 9, 'default1'), (35, 11, NULL), (36, 2, 'A'), (37, 1, 'default2'), (38, 0, 'B'), (39, 1, 'default1'), (40, 3, 'default1'), (41, 7, 'B'), (42, 4, 'C'), (43, 10, 'default1'), (44, 12, NULL), (45, 1, 'default2'), (46, 6, 'C'), (47, 4, 'B'), (48, 3, 'B'), (49, 4, 'default1'), (50, 9, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END AS PA, CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS PB, CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END AS PC FROM ORDERS), TEMP2 AS (SELECT CUSTOMER_ID FROM TEMP GROUP BY CUSTOMER_ID HAVING SUM(PA) > 0 AND SUM(PB) > 0 AND SUM(PC) = 0) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM TEMP2) ORDER BY CUSTOMER_ID;

/*
Prediction Result:
(3, 'A')
*/