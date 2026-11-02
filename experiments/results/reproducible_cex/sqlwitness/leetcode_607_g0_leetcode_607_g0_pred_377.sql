-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, '%RED%', 'default1'), (0, '%RED%', 'default2'), (1, 'RED', 'default2'), (2, '%RED%', NULL), (3, 'default1', 'default2'), (4, 'RED', 'default1'), (5, 'default1', 'default2'), (6, NULL, '%RED%');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 0, NULL, NULL), (1, 'default1', 0, 0, NULL), (0, 'default2', 1, NULL, 'default2'), (2, 'RED', NULL, NULL, 'RED'), (3, NULL, 0, NULL, 'default1'), (4, 'RED', 0, 0, 'RED'), (5, 'default1', 1, 1, NULL), (6, 'default2', 0, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 3, 0, 'default1', 1), (1, 1, 0, 'default2', 0), (-1, 5, 5, '%RED%', NULL), (2, 0, 6, 'default1', NULL), (3, 4, 5, 'RED', 1), (4, 1, 6, NULL, NULL), (5, 2, 0, '%RED%', 0), (6, 6, 3, 'RED', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default1',)
('RED',)
(None,)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM (SELECT SALESPERSON.NAME, GROUP_CONCAT(COMPANY.NAME) AS COMPANIES FROM SALESPERSON LEFT JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID GROUP BY SALESPERSON.NAME HAVING (COMPANIES IS NULL) OR (COMPANIES NOT LIKE '%RED%')) AS OUTPUT;

/*
Prediction Result:
(None,)
('RED',)
*/