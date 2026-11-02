-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'B'), (-1, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, NULL, 'B'), (2, NULL, 'C'), (-1, 0, 'default2'), (1, NULL, 'B'), (3, 0, 'default2'), (4, NULL, 'A'), (5, NULL, 'A'), (6, 0, 'C'), (7, NULL, NULL), (8, NULL, 'A'), (9, 0, 'default1'), (10, NULL, 'C'), (11, 0, 'C'), (12, 0, 'A'), (13, 0, 'default1'), (14, 0, 'B'), (15, -1, 'B'), (16, 0, 'C'), (17, -1, 'A'), (18, 0, NULL), (19, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, None)
*/

-- Prediction Query
SELECT DISTINCT O1.CUSTOMER_ID, C.CUSTOMER_NAME FROM ORDERS AS O1 JOIN ORDERS AS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID LEFT JOIN CUSTOMERS AS C ON O1.CUSTOMER_ID = C.CUSTOMER_ID WHERE O1.PRODUCT_NAME = 'A' AND O2.PRODUCT_NAME = 'B' AND NOT O1.CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
*/