-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'A'), (2, NULL), (3, 'A'), (4, 'B'), (5, 'B'), (6, NULL), (7, 'default2'), (8, NULL), (9, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, NULL), (1, 9, 'C'), (2, 3, 'C'), (3, 5, 'A'), (4, 7, 'B'), (5, 7, NULL), (6, 2, 'default2'), (7, 7, 'default2'), (8, 8, 'default2'), (9, 4, 'default1'), (10, 4, 'default1'), (11, NULL, 'B'), (12, 2, 'C'), (13, 6, NULL), (14, 2, 'default1'), (15, 7, 'default2'), (16, 4, 'C'), (17, 3, 'default2'), (18, 6, 'A'), (19, 5, NULL), (20, 5, 'B'), (21, 2, 'C'), (22, 8, 'default1'), (23, 4, 'C'), (24, 6, 'C'), (25, 0, 'A'), (26, NULL, 'default2'), (27, 6, 'A'), (28, 6, 'B'), (29, 2, 'B'), (30, NULL, 'C'), (31, NULL, 'C'), (32, 6, 'default2'), (33, 6, 'B'), (34, 2, 'B'), (35, 8, 'C'), (36, 0, 'B'), (37, 9, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS A ON A.CUSTOMER_ID = C.CUSTOMER_ID AND A.PRODUCT_NAME = 'A' JOIN ORDERS AS B ON B.CUSTOMER_ID = C.CUSTOMER_ID AND B.PRODUCT_NAME = 'B' LEFT OUTER JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID AND O.PRODUCT_NAME = 'C' WHERE O.ORDER_ID IS NULL ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, 'default2')
(5, 'B')
*/