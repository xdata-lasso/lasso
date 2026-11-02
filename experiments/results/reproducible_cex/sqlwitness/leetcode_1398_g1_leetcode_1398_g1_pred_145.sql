-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (1, 'default1'), (4, 'B'), (0, 'C'), (-1, NULL), (2, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, 1, 'B'), (1, 0, 'A'), (0, 4, 'default2'), (2, 4, 'B'), (4, 2, 'default1'), (3, 2, 'B'), (5, 0, 'C'), (6, 4, 'B'), (7, 0, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 WHEN PRODUCT_NAME = 'B' THEN 1 WHEN PRODUCT_NAME = 'C' THEN 3 ELSE 0 END) AS PRODUCT_SUM FROM ORDERS GROUP BY CUSTOMER_ID) AS TMP WHERE PRODUCT_SUM = 2);

/*
Prediction Result:
(4, 'B')
*/