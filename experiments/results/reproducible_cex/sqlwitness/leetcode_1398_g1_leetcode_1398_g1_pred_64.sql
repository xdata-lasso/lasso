-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (0, 'A'), (2, 'A'), (-1, NULL), (3, NULL), (4, NULL), (5, 'default2'), (6, NULL), (7, 'default1'), (8, 'B');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 6, 'A'), (-1, 6, 'A'), (0, -1, 'default2'), (2, 8, NULL), (3, 4, NULL), (4, 4, 'default1'), (5, 3, 'B'), (6, 1, 'A'), (7, 3, 'default2'), (8, 1, 'default2'), (9, 0, 'C'), (10, 0, 'A'), (11, 3, 'B'), (12, NULL, 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT X.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C INNER JOIN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE NOT CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') AND PRODUCT_NAME IN ('A', 'B') GROUP BY 1 HAVING COUNT(*) > 1) AS X ON X.CUSTOMER_ID = C.CUSTOMER_ID;

/*
Prediction Result:
(3, None)
(6, None)
*/