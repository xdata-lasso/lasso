-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default2'), (0, 'C'), (2, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'C'), (0, 1, 'default2'), (2, 2, 'default2'), (3, NULL, 'C'), (4, 0, 'B'), (5, NULL, NULL), (6, 2, 'default1'), (7, 1, 'A'), (8, 0, 'A'), (9, NULL, 'C'), (10, 2, 'default1'), (11, 2, 'C'), (12, 0, 'default2'), (13, 2, 'default2'), (14, 1, 'B'), (15, 0, 'B'), (16, 0, 'B'), (17, 2, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT A.CUSTOMER_ID, Z.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY 1 HAVING COUNT(DISTINCT PRODUCT_NAME) > 1) AS A LEFT JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('C')) AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID INNER JOIN CUSTOMERS AS Z ON A.CUSTOMER_ID = Z.CUSTOMER_ID WHERE B.CUSTOMER_ID IS NULL;

/*
Prediction Result:
(1, 'default2')
*/