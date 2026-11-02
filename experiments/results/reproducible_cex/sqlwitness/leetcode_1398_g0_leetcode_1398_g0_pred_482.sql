-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'B'), (1, NULL), (0, 'A'), (3, 'default2'), (4, 'C'), (5, 'A'), (6, 'B'), (7, NULL), (8, 'A'), (9, 'default2'), (10, 'B'), (11, NULL), (12, NULL), (13, 'A'), (14, 'C'), (15, 'default2'), (16, 'A'), (17, NULL), (18, 'C'), (19, 'C'), (20, 'B'), (21, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, NULL, NULL), (1, 13, 'A'), (0, 21, 'C'), (3, 1, NULL), (4, 11, 'B'), (5, 13, 'default1'), (6, 10, 'B'), (7, 19, 'A'), (8, 10, 'default1'), (9, 5, 'default2'), (10, 3, NULL), (11, 6, 'A'), (12, 5, 'C'), (13, 7, 'B'), (14, 16, 'B'), (15, 20, 'default2'), (16, 6, 'C'), (17, 15, 'default1'), (18, 18, NULL), (19, 1, 'A'), (20, 18, 'B'), (21, 9, 'default1'), (22, 13, 'default1'), (23, 11, 'default1'), (24, 20, 'default2'), (25, 1, 'A'), (26, 0, NULL), (27, 0, 'C'), (28, 19, 'C'), (29, 19, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT * FROM (SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A INNER JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE B.PRODUCT_NAME = 'A' OR B.PRODUCT_NAME = 'B' GROUP BY A.CUSTOMER_ID HAVING COUNT(DISTINCT ORDER_ID) > 1) AS T WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(1, None)
*/