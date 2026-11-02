-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'default2'), (1, 'C'), (2, 'C'), (0, 'B'), (4, NULL), (5, 'A'), (6, 'A'), (7, NULL), (8, 'A'), (9, 'C'), (10, 'default1'), (11, 'default1'), (12, NULL), (13, 'default1'), (14, 'B'), (15, 'A'), (16, 'default2'), (17, 'B'), (18, NULL), (19, 'C'), (20, NULL), (21, NULL), (22, 'C'), (23, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 22, 'B'), (0, 0, 'default1'), (1, 0, 'A'), (3, 12, NULL), (4, 11, 'A'), (5, 3, 'default2'), (6, 21, NULL), (7, 19, 'A'), (8, 14, 'default1'), (9, NULL, 'default2'), (10, 22, 'C'), (11, 23, 'default1'), (12, 21, 'B'), (13, 12, 'C'), (14, 6, 'B'), (15, 15, NULL), (16, 11, 'B'), (17, 8, 'default2'), (18, 8, 'default2'), (19, 17, 'B'), (20, 14, 'default2'), (21, NULL, 'B'), (22, 12, 'C'), (23, 16, 'default2'), (24, 3, 'C'), (25, 6, 'default2'), (26, 10, 'default2'), (27, 23, 'A'), (28, 13, 'default2'), (29, 23, 'B'), (30, 1, 'C'), (31, 5, NULL), (32, 1, 'A'), (33, NULL, 'default2'), (34, 15, NULL), (35, 11, 'A'), (36, 7, 'default2'), (37, 13, 'B'), (38, 4, 'default1'), (39, 18, NULL), (40, 8, 'C'), (41, 18, 'default2'), (42, 20, NULL), (43, 12, NULL), (44, 18, 'default2'), (45, 18, 'B'), (46, 2, NULL), (47, 5, 'B'), (48, 7, 'C'), (49, 7, 'C'), (50, 1, 'B'), (51, NULL, 'A'), (52, 17, 'C'), (53, 5, NULL), (54, 9, 'A'), (55, 14, 'A'), (56, 7, 'A'), (57, NULL, 'C'), (58, 4, 'A'), (59, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM CUSTOMERS JOIN (SELECT DISTINCT PRODUCT_NAME, CUSTOMER_ID FROM ORDERS) AS UNIQUEPRODUCTORDERS USING (CUSTOMER_ID) GROUP BY CUSTOMERS.CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' OR PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN -1 END) = 2 ORDER BY CUSTOMER_ID, CUSTOMERS.CUSTOMER_ID NULLS LAST, CUSTOMERS.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(11, 'default1')
(23, 'C')
*/