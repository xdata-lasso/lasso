-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'default2'), (2, NULL), (1, 'B'), (0, 'B'), (4, 'B'), (5, '%A%B%'), (6, '%C%'), (7, '%C%'), (8, 'A'), (9, 'B'), (10, '%A%B%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 3, '%A%B%'), (3, 9, 'C'), (1, 6, 'B'), (0, 10, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH BASE_TABLE AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS PRODUCT_LISTS FROM CUSTOMERS LEFT JOIN ORDERS USING (CUSTOMER_ID) GROUP BY 1, 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM BASE_TABLE WHERE PRODUCT_LISTS LIKE '%A%B%' AND PRODUCT_LISTS NOT LIKE '%C%' GROUP BY 1;

/*
Prediction Result:
(3, 'default2')
*/