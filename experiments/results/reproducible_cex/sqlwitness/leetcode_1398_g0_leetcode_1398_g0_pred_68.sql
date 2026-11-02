-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, NULL), (2, 'A'), (3, 'default2'), (4, 'C'), (5, 'C'), (6, NULL), (7, 'default1'), (8, 'C'), (9, NULL), (10, 'B'), (11, 'A'), (12, 'B'), (13, 'default2'), (14, 'B'), (15, 'default1'), (16, NULL), (17, 'default1'), (18, 'default2'), (19, 'default2'), (20, 'default2'), (21, 'default2'), (22, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 17, 'C'), (1, 10, NULL), (2, 4, 'B'), (3, 18, 'B'), (4, 13, NULL), (5, 6, NULL), (6, 15, 'B'), (7, 1, 'A'), (8, 2, 'default2'), (9, 22, 'B'), (10, NULL, NULL), (11, 15, 'A'), (12, 18, NULL), (13, 2, 'A'), (14, 20, NULL), (15, NULL, 'C'), (16, 6, NULL), (17, 18, 'default2'), (18, 3, 'C'), (19, NULL, 'default2'), (20, 8, 'B'), (21, 16, 'default1'), (22, 3, 'A'), (23, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH A_BUYER AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A' GROUP BY CUSTOMER_ID), B_BUYER AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B' GROUP BY CUSTOMER_ID), C_BUYER AS (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C' GROUP BY CUSTOMER_ID), AB_BUYER AS (SELECT A.CUSTOMER_ID FROM A_BUYER AS A INNER JOIN B_BUYER AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID), RES AS (SELECT AB.CUSTOMER_ID FROM AB_BUYER AS AB LEFT JOIN C_BUYER AS C ON AB.CUSTOMER_ID = C.CUSTOMER_ID WHERE C.CUSTOMER_ID IS NULL) SELECT R.CUSTOMER_ID, C2.CUSTOMER_NAME FROM RES AS R JOIN CUSTOMERS AS C2 ON R.CUSTOMER_ID = C2.CUSTOMER_ID;

/*
Prediction Result:
(15, 'default1')
*/