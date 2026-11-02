-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (-1, 'B'), (1, 'default2'), (2, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 0, 'default1'), (-1, 1, 'A'), (2, NULL, 'C'), (1, 0, 'default1'), (3, 2, 'default2'), (4, 1, NULL), (5, 2, NULL), (6, 2, 'A'), (7, 1, NULL), (8, 0, 'B'), (9, NULL, 'default2'), (10, NULL, NULL), (11, NULL, 'A'), (12, -1, NULL), (13, 0, NULL), (14, 2, 'A'), (15, NULL, 'C'), (16, 2, 'B'), (17, -1, 'default2'), (18, 2, 'A'), (19, 1, 'C'), (20, 0, 'default2'), (21, 0, 'C'), (22, -1, 'A'), (23, 0, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH ORDER_TYPE AS (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END AS IS_A_PURCHASE, CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END AS IS_B_PURCHASE, CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END AS IS_C_PURCHASE FROM ORDERS) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM ORDER_TYPE INNER JOIN CUSTOMERS USING (CUSTOMER_ID) GROUP BY CUSTOMER_ID, CUSTOMER_NAME HAVING (MAX(IS_A_PURCHASE) > 0 AND MAX(IS_B_PURCHASE) > 0 AND MAX(IS_C_PURCHASE) = 0) ORDER BY CUSTOMER_ID ASC, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(2, None)
*/