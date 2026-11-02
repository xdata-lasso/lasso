-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (0, 'default2'), (2, NULL), (3, '%C%'), (4, NULL), (5, '%C%'), (6, NULL), (7, NULL), (8, '%B%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 4, 'default1'), (0, 0, 'default2'), (2, 2, '%A%'), (3, 6, 'default1'), (4, 7, NULL), (5, 1, '%B%'), (6, 0, 'B'), (7, 6, 'default1'), (8, 0, '%A%'), (9, 2, '%A%'), (10, 8, '%B%'), (11, 6, 'C'), (12, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.* FROM (SELECT CUSTOMER_ID FROM ORDERS GROUP BY CUSTOMER_ID HAVING GROUP_CONCAT(PRODUCT_NAME) LIKE '%A%' AND GROUP_CONCAT(PRODUCT_NAME) LIKE '%B%' AND GROUP_CONCAT(PRODUCT_NAME) NOT LIKE '%C%') AS T JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = T.CUSTOMER_ID ORDER BY C.CUSTOMER_ID;

/*
Prediction Result:
(0, 'default2')
*/