-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'C'), (2, 'default2'), (3, 'C'), (4, 'default1'), (5, NULL), (6, NULL), (7, 'B'), (8, 'B'), (9, 'default1'), (10, 'B'), (11, 'default2'), (12, 'C'), (13, 'A'), (14, NULL), (15, 'B'), (16, 'default2'), (17, 'default1'), (18, 'C'), (19, NULL), (20, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 14, 'default2'), (1, 8, 'default1'), (2, NULL, 'default1'), (3, 2, NULL), (4, 3, 'default1'), (5, 19, 'default1'), (6, 1, 'default2'), (7, 20, 'A'), (8, 10, 'default1'), (9, 1, 'A'), (10, 11, NULL), (11, 7, 'B'), (12, 2, 'default2'), (13, 16, 'A'), (14, 19, 'B'), (15, 3, 'B'), (16, 20, 'default1'), (17, 7, 'B'), (18, 11, NULL), (19, 19, 'B'), (20, 0, 'B'), (21, 6, NULL), (22, 12, NULL), (23, 7, 'A'), (24, 8, 'C'), (25, 4, 'B'), (26, 14, 'B'), (27, 16, 'C'), (28, 6, 'A'), (29, 13, 'default2'), (30, 9, NULL), (31, 6, NULL), (32, 6, 'B'), (33, 17, 'A'), (34, 3, 'B'), (35, 6, 'A'), (36, 15, 'A'), (37, 4, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(6, None)
(7, 'B')
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT (A1.CUSTOMER_ID) FROM ORDERS AS A1 CROSS JOIN ORDERS AS A2 CROSS JOIN ORDERS AS A3 WHERE A1.PRODUCT_NAME = 'A' AND A2.PRODUCT_NAME = 'B' AND A3.PRODUCT_NAME <> 'C' AND A1.CUSTOMER_ID = A2.CUSTOMER_ID AND A2.CUSTOMER_ID = A3.CUSTOMER_ID) SELECT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM A AS A LEFT JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(7, 'B')
(6, None)
*/