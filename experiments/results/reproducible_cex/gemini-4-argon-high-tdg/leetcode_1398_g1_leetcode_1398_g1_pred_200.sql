-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 5
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Valid_With_Null_Product');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, NULL);
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Invalid_With_Null_Product');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 1, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 2, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 2, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 3, NULL);
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, NULL, 'C');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, NULL, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(1, 'Valid_With_Null_Product')
(2, None)
*/

-- Prediction Query
WITH CTE AS (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME IN ('A') THEN 1 ELSE 0 END AS A FROM ORDERS) AS X WHERE A <> 0), CTE1 AS (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME IN ('B') THEN 1 ELSE 0 END AS B FROM ORDERS) AS X WHERE B <> 0), CTE2 AS (SELECT CUSTOMER_ID FROM (SELECT CUSTOMER_ID, CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END AS C FROM ORDERS) AS Y WHERE C = 1) SELECT DISTINCT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT * FROM CTE) AND CUSTOMER_ID IN (SELECT * FROM CTE1) AND NOT CUSTOMER_ID IN (SELECT * FROM CTE2) ORDER BY 1, CUSTOMER_ID NULLS LAST, CUSTOMER_NAME NULLS LAST;

/*
Prediction Result:
*/