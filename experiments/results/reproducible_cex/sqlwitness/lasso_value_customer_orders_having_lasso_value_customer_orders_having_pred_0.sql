-- Schema DDL
CREATE TABLE CUSTOMERS (CUSTOMER_ID INTEGER PRIMARY KEY, CUSTOMER_NAME TEXT(255));

CREATE TABLE ORDERS (ORDER_ID INTEGER PRIMARY KEY, CUSTOMER_ID INTEGER, PRODUCT_NAME TEXT(255), FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS (CUSTOMER_ID));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO customers (customer_id, customer_name) VALUES (2, 'A'), (-1, NULL), (0, 'default2'), (1, 'default1'), (3, 'B'), (4, NULL), (5, NULL), (6, 'default2'), (7, 'default2'), (8, NULL), (9, 'A'), (10, 'C'), (11, 'default2'), (12, 'C'), (13, 'C'), (14, 'C'), (15, 'default2'), (16, 'default1'), (17, 'A'), (18, NULL), (19, 'default2'), (20, 'default2'), (21, 'B'), (22, NULL), (23, 'default1'), (24, NULL), (25, 'default2'), (26, 'default1'), (27, 'C'), (28, 'C');
INSERT INTO orders (order_id, customer_id, product_name) VALUES (0, 19, 'default2'), (-1, 23, 'B'), (2, 27, 'C'), (1, 27, NULL), (3, 2, 'default2'), (4, 7, 'C'), (5, 8, 'C'), (6, 22, 'default2'), (7, NULL, 'C'), (8, 10, NULL), (9, 16, 'B'), (10, 15, 'C'), (11, 10, 'default1'), (12, 2, NULL), (13, 20, NULL), (14, 10, 'B'), (15, 20, 'default2'), (16, 16, NULL), (17, 17, 'B'), (18, 25, NULL), (19, 26, 'B'), (20, 7, NULL), (21, 11, 'default2'), (22, 20, 'A'), (23, 5, 'C'), (24, 20, 'A'), (25, 1, 'default1'), (26, 6, 'B'), (27, 28, NULL), (28, 16, 'A'), (29, 3, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'A') AND CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'B') AND NOT CUSTOMER_ID IN (SELECT DISTINCT CUSTOMER_ID FROM ORDERS WHERE PRODUCT_NAME = 'C') ORDER BY CUSTOMER_ID;

/*
Gold Result:
*/

-- Prediction Query
SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME FROM CUSTOMERS AS C JOIN ORDERS AS O ON (C.CUSTOMER_ID = O.CUSTOMER_ID) GROUP BY C.CUSTOMER_ID HAVING SUM(CASE WHEN PRODUCT_NAME = 'A' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'B' THEN 1 ELSE 0 END) > 0 AND SUM(CASE WHEN PRODUCT_NAME = 'C' THEN 1 ELSE 0 END) = 0;

/*
Prediction Result:
(16, 'default1')
*/