-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'B'), (0, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'default1'), (1, 1, 'default2'), (2, 0, 'A'), (3, 0, '%A%B%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS P FROM ORDERS GROUP BY CUSTOMER_ID) AS A JOIN CUSTOMERS AS C ON A.CUSTOMER_ID = C.CUSTOMER_ID WHERE P LIKE '%A%B%' AND P NOT LIKE '%C%';

/*
Prediction Result:
(0, 'C')
*/