-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO orders (order_id, customer_id, product_name) VALUES (-1, NULL, 'B'), (2, NULL, 'default1'), (0, NULL, 'A'), (1, NULL, 'default1'), (3, NULL, 'default1'), (4, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.* FROM (SELECT O.CUSTOMER_ID, SUM(O.PRODUCT_NAME = 'A') AS A, SUM(O.PRODUCT_NAME = 'B') AS B, SUM(O.PRODUCT_NAME = 'C') AS C FROM ORDERS AS O GROUP BY O.CUSTOMER_ID) AS OO LEFT OUTER JOIN CUSTOMERS AS C ON C.CUSTOMER_ID = OO.CUSTOMER_ID WHERE OO.A > 0 AND OO.B > 0 AND OO.C = 0;

/*
Prediction Result:
(None, None)
*/