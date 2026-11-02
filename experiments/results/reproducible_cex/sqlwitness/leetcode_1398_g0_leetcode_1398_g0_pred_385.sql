-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, NULL), (2, NULL), (3, '%A,B%'), (4, 'B'), (5, '%A,B%'), (6, '%C%'), (7, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 0, 'default1'), (0, 2, 'A'), (2, 4, 'A'), (3, 6, 'C'), (4, 2, 'B'), (5, 5, '%A,B%'), (6, 3, '%C%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
(2, None)
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS PRODUCTS FROM ORDERS GROUP BY CUSTOMER_ID HAVING PRODUCTS NOT LIKE '%C%' AND PRODUCTS LIKE '%A,B%') AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID;

/*
Prediction Result:
(2, None)
(5, '%A,B%')
*/