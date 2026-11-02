-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, 'default2'), (2, 'default2'), (1, 'A,B%'), (-1, 'A,B%'), (3, 'default1');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (2, 0, 'A,B%'), (1, 1, 'default2'), (-1, 3, 'B'), (0, 2, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH A AS (SELECT O.CUSTOMER_ID, C.CUSTOMER_NAME, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS ALL_P FROM ORDERS AS O JOIN CUSTOMERS AS C ON O.CUSTOMER_ID = C.CUSTOMER_ID GROUP BY 1) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM A WHERE ALL_P LIKE ('A,B%') AND ALL_P NOT LIKE ('%C%');

/*
Prediction Result:
(0, 'default2')
*/