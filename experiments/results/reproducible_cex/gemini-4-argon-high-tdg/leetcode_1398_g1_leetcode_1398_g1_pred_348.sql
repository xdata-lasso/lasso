-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 6
INSERT INTO Customers (customer_id, customer_name) VALUES (1, 'Lower_ab');
INSERT INTO Customers (customer_id, customer_name) VALUES (2, 'Substring_AB_BC');
INSERT INTO Customers (customer_id, customer_name) VALUES (3, 'Upper_AB_Lower_c');
INSERT INTO Customers (customer_id, customer_name) VALUES (4, 'Upper_AB_Substring_CA');
INSERT INTO Customers (customer_id, customer_name) VALUES (5, 'Upper_AB_Zero');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (1, 1, 'a');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (2, 1, 'b');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (3, 2, 'AB');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (4, 2, 'BC');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (5, 3, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (6, 3, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (7, 3, 'c');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (8, 4, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (9, 4, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (10, 4, 'CA');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (11, 5, 'A');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (12, 5, 'B');
INSERT INTO Orders (order_id, customer_id, product_name) VALUES (13, 5, '0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
(3, 'Upper_AB_Lower_c')
(4, 'Upper_AB_Substring_CA')
(5, 'Upper_AB_Zero')
*/

-- Prediction Query
SELECT CUSTOMERS.CUSTOMER_ID, CUSTOMERS.CUSTOMER_NAME FROM CUSTOMERS LEFT JOIN (SELECT CUSTOMER_ID, GROUP_CONCAT(PRODUCT_NAME) AS SHOPLIST FROM ORDERS GROUP BY CUSTOMER_ID) AS T1 ON CUSTOMERS.CUSTOMER_ID = T1.CUSTOMER_ID WHERE SHOPLIST LIKE '%A%' AND SHOPLIST LIKE '%B%' AND SHOPLIST NOT LIKE '%C%';

/*
Prediction Result:
(1, 'Lower_ab')
(5, 'Upper_AB_Zero')
*/