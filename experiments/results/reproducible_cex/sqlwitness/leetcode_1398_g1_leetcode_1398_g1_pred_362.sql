-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (-1, '%A%'), (3, 'A'), (2, 'default2'), (0, '%B%'), (1, 'B'), (4, 'B'), (5, '%B%'), (6, 'default1'), (7, '%C%'), (8, NULL), (9, '%C%'), (10, 'B'), (11, NULL), (12, 'default1'), (13, 'A'), (14, '%A%'), (15, '%A%'), (16, '%C%');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 4, '%A%'), (1, 5, 'A'), (-1, 12, '%A%'), (2, 15, 'default1'), (0, 13, 'B'), (4, 11, 'A'), (5, 16, NULL), (6, 6, 'B'), (7, 14, '%A%'), (8, 9, 'A'), (9, 10, 'default2'), (10, 14, 'A'), (11, 11, '%B%'), (12, 3, 'default1'), (13, 15, '%C%'), (14, -1, '%B%');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
WITH TEMP AS (SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, GROUP_CONCAT(O.PRODUCT_NAME) AS PRD_GRPS FROM CUSTOMERS AS C LEFT JOIN ORDERS AS O ON C.CUSTOMER_ID = O.CUSTOMER_ID GROUP BY 1, 2) SELECT CUSTOMER_ID, CUSTOMER_NAME FROM TEMP WHERE (PRD_GRPS LIKE '%A%' AND PRD_GRPS LIKE '%B%') AND (PRD_GRPS NOT LIKE '%C%');

/*
Prediction Result:
(11, None)
*/