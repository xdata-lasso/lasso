-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'A'), (3, 'A'), (2, 'default2'), (4, 'default1'), (5, 'default1'), (6, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 5, 'default1'), (3, 4, 'A'), (2, NULL, NULL), (1, 1, NULL), (4, 6, 'default2'), (5, 1, 'C'), (6, 4, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O USING (CUSTOMER_ID) WHERE O.PRODUCT_NAME IN ('A', 'B') AND NOT C.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY O.CUSTOMER_ID HAVING COUNT(O.PRODUCT_NAME) = 2 ORDER BY C.CUSTOMER_ID, C.CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(4, 'default1')
*/