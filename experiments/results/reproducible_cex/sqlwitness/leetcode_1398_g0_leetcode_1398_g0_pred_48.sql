-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, '%A%'), (0, 'A'), (2, '%C%'), (3, 'default2'), (4, 'C'), (5, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 4, 'A'), (1, 3, '%B%'), (2, 2, '%B%'), (3, 3, 'default2'), (4, 5, 'default1'), (5, 4, '%B%'), (6, 5, 'default1'), (7, 0, '%A%'), (8, 3, '%B%'), (9, 0, NULL), (10, 1, 'default1'), (11, 4, 'default1'), (12, 0, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDERS JOIN CUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMER_ID HAVING GROUP_CONCAT(PRODUCT_NAME) LIKE '%A%' AND GROUP_CONCAT(PRODUCT_NAME) LIKE '%B%' AND GROUP_CONCAT(PRODUCT_NAME) NOT LIKE '%C%';

/*
Prediction Result:
(3, 'default2')
(4, 'C')
*/