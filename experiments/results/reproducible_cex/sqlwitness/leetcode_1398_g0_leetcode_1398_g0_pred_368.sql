-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'default2'), (0, 'default2'), (1, NULL), (3, 'A'), (4, 'B'), (5, NULL), (6, 'B'), (7, NULL), (8, NULL), (9, NULL), (10, 'B'), (11, NULL), (12, 'default1'), (13, 'C'), (14, 'A'), (15, 'default1'), (16, 'default2'), (17, 'default1'), (18, 'C'), (19, 'default1'), (20, 'B'), (21, NULL), (22, 'default1'), (23, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 12, 'default1'), (2, NULL, 'C'), (1, 14, 'C'), (3, 0, 'default1'), (4, 9, NULL), (5, 17, 'A'), (6, 2, 'C'), (7, 20, 'default1'), (8, 5, 'B'), (9, 6, NULL), (10, 7, 'A'), (11, 4, 'default2'), (12, 20, 'C'), (13, 15, NULL), (14, 21, 'B'), (15, 20, 'B'), (16, 1, NULL), (17, 5, 'A'), (18, 19, 'default1'), (19, 4, 'default2'), (20, 19, NULL), (21, 23, NULL), (22, 8, 'A'), (23, 8, 'default1'), (24, 7, 'A'), (25, 9, NULL), (26, 20, 'default1'), (27, 20, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT C1.CUSTOMER_ID, C1.CUSTOMER_NAME FROM CUSTOMERS AS C1 JOIN ORDERS AS O1 ON C1.CUSTOMER_ID = O1.CUSTOMER_ID JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID AND O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' LEFT JOIN ORDERS AS O3 ON O3.CUSTOMER_ID = O2.CUSTOMER_ID AND O3.PRODUCT_NAME = 'C' WHERE O3.CUSTOMER_ID IS NULL ORDER BY 1, C1.CUSTOMER_ID NULLS LAST, C1.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(5, None)
*/