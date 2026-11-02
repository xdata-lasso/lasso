-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'A'), (1, 'C'), (2, 'default2'), (3, 'C'), (4, 'C'), (5, '%C%'), (6, 'C'), (7, 'default2'), (8, '%C%'), (9, 'A'), (10, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 6, 'C'), (1, 5, 'B'), (2, 7, 'default1'), (3, 0, 'C'), (4, 0, 'default2'), (5, 7, 'A'), (6, 5, '%A%'), (7, NULL, '%B%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TMP1 AS (SELECT CUSTOMER_ID, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS GRP FROM ORDERS GROUP BY CUSTOMER_ID), TMP2 AS (SELECT * FROM TMP1 WHERE GRP LIKE '%A%' AND GRP LIKE '%B%' AND GRP NOT LIKE '%C%') SELECT CUSTOMER_ID, CUSTOMER_NAME FROM TMP2 INNER JOIN CUSTOMERS USING (CUSTOMER_ID);

/*
Prediction Result:
(5, '%C%')
*/