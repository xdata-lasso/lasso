-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'C'), (0, '%A,B%'), (2, 'C'), (3, 'B'), (4, NULL), (5, 'A'), (6, '%A,B%'), (7, '%C%'), (8, 'C'), (9, '%C%'), (10, 'A'), (11, '%C%'), (12, 'B'), (13, '%C%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 8, '%A,B%'), (1, 12, 'C'), (2, NULL, '%C%'), (3, 0, 'default2'), (4, 3, '%A,B%'), (5, 5, 'default1'), (6, 5, 'C'), (7, 7, 'A'), (8, 10, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE PRODUCTS LIKE '%A,B%' AND PRODUCTS NOT LIKE '%C%';

/*
Prediction Result:
(3, 'B')
(8, 'C')
*/