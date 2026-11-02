-- Schema DDL
CREATE TABLE "Customers" ("customer_id" INTEGER PRIMARY KEY, "customer_name" TEXT(255));

CREATE TABLE "Orders" ("order_id" INTEGER PRIMARY KEY, "customer_id" INTEGER, "product_name" TEXT(255), FOREIGN KEY ("customer_id") REFERENCES "Customers" ("customer_id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (0, NULL), (1, 'default2');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (1, NULL, 'default2'), (2, NULL, '%A%B%'), (0, NULL, 'default2'), (-1, NULL, 'C'), (3, 0, NULL), (4, 0, '%A%B%'), (5, 1, '%A%B%'), (6, 1, 'B');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMERS.CUSTOMER_ID AS CUSTOMER_ID, CUSTOMER_NAME FROM (SELECT CUSTOMER_ID, SUM(IIF(PRODUCT_NAME = 'A', 1, 0)) AS A, SUM(IIF(PRODUCT_NAME = 'B', 1, 0)) AS B, SUM(IIF(PRODUCT_NAME = 'C', 1, 0)) AS C FROM ORDERS GROUP BY CUSTOMER_ID) AS INTER JOIN CUSTOMERS ON CUSTOMERS.CUSTOMER_ID = INTER.CUSTOMER_ID WHERE A > 0 AND B > 0 AND C = 0 ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT P.CUSTOMER_ID, C.CUSTOMER_NAME FROM (SELECT GROUP_CONCAT(DISTINCT PRODUCT_NAME) AS ALLPRODUCTS, CUSTOMER_ID FROM ORDERS GROUP BY CUSTOMER_ID) AS P JOIN CUSTOMERS AS C ON P.CUSTOMER_ID = C.CUSTOMER_ID WHERE P.ALLPRODUCTS LIKE '%A%B%' AND P.ALLPRODUCTS NOT LIKE '%C%';

/*
Prediction Result:
(0, None)
(1, 'default2')
*/