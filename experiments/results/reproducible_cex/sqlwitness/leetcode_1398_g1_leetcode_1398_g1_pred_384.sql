-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, 'C'), (3, 'default2'), (2, NULL), (1, NULL), (0, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'C'), (2, 1, 'default2'), (3, 1, 'default1'), (0, 1, 'A'), (1, -1, 'C'), (4, 0, NULL), (5, 0, 'A'), (6, 0, 'default2'), (7, -1, 'A'), (8, 1, 'C'), (9, -1, 'A'), (10, 2, 'B'), (11, NULL, 'A'), (12, -1, 'default1'), (13, 0, NULL), (14, 3, 'default1'), (15, -1, 'default1'), (16, NULL, 'default2'), (17, 3, 'default1'), (18, 0, 'B'), (19, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(0, 'C')
*/

-- Prediction Query
SELECT * FROM CUSTOMERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME IN ('A', 'B') GROUP BY CUSTOMER_ID HAVING COUNT(DISTINCT PRODUCT_NAME) = 2) ORDER BY CUSTOMER_ID ASC;

/*
Prediction Result:
*/