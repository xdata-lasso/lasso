-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (3, 'C'), (1, 'default2'), (2, 'B'), (-1, 'B'), (0, 'C'), (4, 'A'), (5, 'C'), (6, 'default2'), (7, NULL), (8, 'default1'), (9, 'default1'), (10, 'default1'), (11, 'default2'), (12, 'default1'), (13, 'B'), (14, 'default2'), (15, 'A'), (16, NULL);
INSERT INTO orders (order_id, customer_id, product_name) VALUES (3, 13, 'B'), (-1, 4, NULL), (0, 9, 'B'), (2, 10, 'C'), (1, -1, 'A'), (4, 0, 'default2'), (5, 16, 'A'), (6, 6, 'default1'), (7, NULL, 'default2'), (8, NULL, 'C'), (9, 15, 'A'), (10, 4, 'C'), (11, 10, 'default2'), (12, 9, 'default2'), (13, 4, 'default1'), (14, -1, 'B'), (15, 1, NULL), (16, 10, 'default2'), (17, 11, 'B'), (18, 2, 'default1'), (19, 14, 'A'), (20, 8, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(-1, 'B')
*/

-- Prediction Query
SELECT A.CUSTOMER_ID, A.CUSTOMER_NAME FROM CUSTOMERS AS A INNER JOIN ORDERS AS B ON A.CUSTOMER_ID = B.CUSTOMER_ID WHERE B.PRODUCT_NAME IN ('A', 'B') AND NOT A.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') GROUP BY A.CUSTOMER_ID, A.CUSTOMER_NAME HAVING COUNT(B.PRODUCT_NAME) >= 2;

/*
Prediction Result:
*/