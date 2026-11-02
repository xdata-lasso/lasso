-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 3
INSERT INTO Customers (customer_id, customer_name) VALUES (30, 'Alice');
INSERT INTO Customers (customer_id, customer_name) VALUES (10, 'Zack');
INSERT INTO Customers (customer_id, customer_name) VALUES (20, 'Mike');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 30, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 30, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 20, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 20, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 10, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 10, 'A');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(10, 'Zack')
(20, 'Mike')
(30, 'Alice')
*/

-- Prediction Query
SELECT DISTINCT ORDERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM ORDERS INNER JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID WHERE ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT ORDERS.CUSTOMER_ID IN (SELECT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C');

/*
Prediction Result:
(30, 'Alice')
(20, 'Mike')
(10, 'Zack')
*/