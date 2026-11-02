-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, '%C%'), (1, '%A%B%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, 2, 'A'), (0, 1, 'default2'), (-1, 1, '%A%B%'), (3, NULL, 'default2'), (2, 1, NULL), (4, 1, 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH BASE_TABLE AS (SELECT CUSTOMER_ID, CUSTOMER_NAME, GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS PRODUCT_LISTS FROM CUSTOMERS LEFT JOIN ORDERS USING (CUSTOMER_ID) GROUP BY 1, 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM BASE_TABLE WHERE PRODUCT_LISTS LIKE '%A%B%' AND PRODUCT_LISTS NOT LIKE '%C%' GROUP BY 1;

/*
Prediction Result:
(1, '%A%B%')
*/