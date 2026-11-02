-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (1, 'B'), (2, 'A'), (3, 'B'), (4, 'default1'), (5, 'B'), (6, 'C'), (7, 'default1'), (8, 'C'), (9, 'B'), (10, 'C'), (11, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 8, 'B'), (1, 4, 'A'), (2, 2, 'default1'), (3, 5, NULL), (4, 3, NULL), (5, 3, 'B'), (6, NULL, 'default2'), (7, 9, 'A'), (8, 3, 'C'), (9, 8, NULL), (10, 11, 'B'), (11, 0, 'default2'), (12, 2, 'A'), (13, 7, 'C'), (14, 8, 'C'), (15, 5, 'default1'), (16, 11, 'default2'), (17, 10, 'default2'), (18, 6, 'default1'), (19, 6, 'default2'), (20, 4, 'B'), (21, 9, 'default1'), (22, NULL, 'C'), (23, NULL, NULL), (24, 8, 'B'), (25, 9, 'A'), (26, 0, 'A'), (27, 0, 'default2'), (28, 6, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS A ON A.CUSTOMER_ID = C.CUSTOMER_ID AND A.PRODUCT_NAME = 'A' JOIN ORDERS AS B ON B.CUSTOMER_ID = C.CUSTOMER_ID AND B.PRODUCT_NAME = 'B' LEFT JOIN ORDERS AS O ON O.CUSTOMER_ID = C.CUSTOMER_ID AND O.PRODUCT_NAME = 'C' WHERE O.ORDER_ID IS NULL;

/*
Prediction Result:
(4, 'default1')
*/