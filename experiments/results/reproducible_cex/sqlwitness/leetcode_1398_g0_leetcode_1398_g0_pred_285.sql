-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, NULL), (2, NULL), (3, 'B'), (4, 'A'), (5, 'default1'), (6, 'B'), (7, 'C'), (8, 'A'), (9, 'A'), (10, 'C'), (11, 'default2'), (12, 'A'), (13, 'default1'), (14, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'C'), (0, 7, 'A'), (2, 7, 'B'), (3, 10, 'default1'), (4, 14, NULL), (5, 1, NULL), (6, 11, 'default1'), (7, 5, 'A'), (8, 0, 'B'), (9, 0, NULL), (10, 12, 'default2'), (11, NULL, 'C'), (12, 5, 'default2'), (13, 12, NULL), (14, 3, 'default2'), (15, 7, 'A'), (16, 8, 'default2'), (17, 7, 'default2'), (18, 9, 'C'), (19, 4, 'A'), (20, 7, 'default1'), (21, 7, NULL), (22, 12, 'A'), (23, 3, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A'), B AS (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B'), C AS (SELECT CU.CUSTOMER_ID FROM CUSTOMERS AS CU LEFT JOIN ORDERS AS O ON CU.CUSTOMER_ID = O.CUSTOMER_ID AND PRODUCT_NAME = 'C' WHERE O.CUSTOMER_ID IS NULL) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT A.CUSTOMER_ID FROM A CROSS JOIN B CROSS JOIN C WHERE A.CUSTOMER_ID = C.CUSTOMER_ID AND B.CUSTOMER_ID = C.CUSTOMER_ID);

/*
Prediction Result:
(7, 'C')
*/