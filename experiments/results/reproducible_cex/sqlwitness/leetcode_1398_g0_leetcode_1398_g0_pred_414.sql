-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (2, NULL), (0, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 1, 'A'), (2, 2, 'C'), (0, 0, 'default2'), (-1, 0, NULL), (3, 0, 'default2'), (4, 0, NULL), (5, 1, 'default1'), (6, NULL, 'A'), (7, NULL, 'C'), (8, 0, NULL), (9, 0, 'A'), (10, NULL, 'A'), (11, NULL, 'A'), (12, 2, 'default2'), (13, 0, NULL), (14, 0, 'B'), (15, NULL, 'A'), (16, 2, 'B'), (17, 0, 'default2'), (18, 1, 'B'), (19, 0, 'B'), (20, NULL, 'C');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS LEFT JOIN ORDERS USING (CUSTOMER_ID) GROUP BY 1 HAVING SUM(PRODUCT_NAME = 'A') > 0 AND SUM(PRODUCT_NAME = 'B') > 0 AND SUM(PRODUCT_NAME = 'C') = 0 ORDER BY 1, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
(0, None)
(1, 'default1')
*/