-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (1, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'C'), (0, NULL, 'default2'), (2, NULL, 'B'), (3, 1, 'C'), (4, 1, 'C'), (5, 1, 'A'), (6, 1, NULL), (7, 0, 'default2'), (8, 1, 'B'), (9, 1, NULL), (10, NULL, NULL), (11, 0, 'default2'), (12, NULL, 'A'), (13, 0, 'B'), (14, NULL, 'default1'), (15, 1, 'C'), (16, 1, 'C'), (17, NULL, 'default2'), (18, 0, 'A'), (19, 0, 'B'), (20, NULL, 'B'), (21, NULL, 'default2'), (22, 1, 'C'), (23, NULL, 'default2'), (24, 1, 'default2'), (25, 1, 'default1'), (26, 1, 'A'), (27, NULL, 'default2'), (28, 1, 'C'), (29, 1, 'B'), (30, 1, 'A'), (31, 0, 'A'), (32, NULL, 'C'), (33, 1, NULL), (34, 1, 'default2'), (35, 1, 'default2'), (36, NULL, 'C'), (37, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT E.CUSTOMER_ID FROM ORDERS AS E JOIN ORDERS AS F ON E.CUSTOMER_ID = F.CUSTOMER_ID WHERE E.PRODUCT_NAME IN ('A') AND F.PRODUCT_NAME = 'B') AS A LEFT JOIN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C')) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE B.CUSTOMER_ID IS NULL GROUP BY A.CUSTOMER_ID ORDER BY A.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, 'B')
*/