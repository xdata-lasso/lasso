-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'default1'), (1, 'C'), (2, 'C'), (0, 'default2'), (4, 'C'), (5, 'default1'), (6, 'A'), (7, 'A'), (8, 'A'), (9, NULL), (10, 'default1'), (11, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 10, 'default2'), (2, 11, 'B'), (3, NULL, 'C'), (1, 9, 'default2'), (4, 5, 'default2'), (5, 4, 'default1'), (6, 11, 'B'), (7, 9, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT T3.* FROM (SELECT T1.CUSTOMER_ID, CNT1, CNT2 FROM (SELECT CUSTOMER_ID, COUNT(DISTINCT ORDER_ID) AS CNT1 FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID) AS T1 LEFT JOIN (SELECT CUSTOMER_ID, COUNT(DISTINCT ORDER_ID) AS CNT2 FROM ORDERS WHERE PRODUCT_NAME IN ('C') GROUP BY CUSTOMER_ID) AS T2 ON T1.CUSTOMER_ID = T2.CUSTOMER_ID WHERE CNT1 >= 2) AS T INNER JOIN (SELECT * FROM CUSTOMERS) AS T3 ON T.CUSTOMER_ID = T3.CUSTOMER_ID WHERE CNT2 IS NULL;

/*
Prediction Result:
(11, 'default1')
*/