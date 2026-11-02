-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'C'), (2, 'B'), (3, 'C'), (4, 'C'), (5, 'A'), (6, 'default2'), (7, '%C%'), (8, 'C'), (9, 'default2'), (10, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 3, 'default2'), (1, 3, '%B%'), (2, 6, 'default2'), (3, 9, 'B'), (4, 4, 'C'), (5, NULL, 'default1'), (6, 0, NULL), (7, NULL, 'B'), (8, 1, NULL), (9, 10, '%A%'), (10, 1, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID AS ID, S.PRODUCTS FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID) AS S WHERE S.PRODUCTS LIKE '%A%' AND S.PRODUCTS LIKE '%B%' AND S.PRODUCTS NOT LIKE '%C%') AS SS CROSS JOIN CUSTOMERS AS C WHERE C.CUSTOMER_ID = SS.ID;

/*
Prediction Result:
(3, 'C')
*/