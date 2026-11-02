-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'A'), (-1, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, -1, 'default2'), (2, -1, 'B'), (1, 1, NULL), (-1, NULL, 'A'), (3, -1, 'A'), (4, -1, 'default2'), (5, -1, 'default1'), (6, 1, 'default2'), (7, NULL, 'C'), (8, -1, 'B'), (9, 1, 'default1'), (10, 1, 'default1'), (11, 1, NULL), (12, NULL, 'B'), (13, -1, 'B'), (14, 1, 'B'), (15, 1, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT V.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) AS SA, SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) AS SB, SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) AS SC FROM ORDERS AS O WHERE 1 = 1 GROUP BY CUSTOMER_ID) AS V JOIN CUSTOMERS AS C ON V.CUSTOMER_ID = C.CUSTOMER_ID WHERE V.SA > 0 AND V.SB > 0 AND V.SC = 0 ORDER BY V.CUSTOMER_ID, C.customer_id NULLS LAST;

/*
Prediction Result:
(-1, 'B')
*/