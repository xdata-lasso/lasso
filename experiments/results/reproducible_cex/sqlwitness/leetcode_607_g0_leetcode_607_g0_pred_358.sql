-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', NULL), (1, 'default2', NULL), (-1, NULL, 'RED'), (2, 'default1', 'RED'), (3, 'default2', NULL), (4, 'RED', 'RED'), (5, 'RED', 'RED'), (6, 'RED', 'default1'), (7, 'RED', 'default2'), (8, 'default1', 'default2'), (9, 'default1', 'default2'), (10, 'default1', NULL), (11, NULL, 'RED'), (12, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 1, NULL, 'default1'), (0, 'default2', 1, 0, 'RED'), (-1, 'RED', NULL, 0, 'default1'), (2, 'default2', 1, NULL, NULL), (3, 'RED', 1, NULL, 'default2'), (4, 'RED', NULL, 0, 'default1'), (5, 'default2', NULL, NULL, 'RED'), (6, 'RED', NULL, 1, 'default2'), (7, 'default1', 1, 0, 'default1'), (8, 'RED', NULL, 0, NULL), (9, 'default2', 0, 0, NULL), (10, 'default1', 0, NULL, NULL), (11, 'RED', 0, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 5, 1, 'default2', 0), (0, 10, 6, 'default1', NULL), (-1, 6, 9, 'default1', 1), (2, NULL, 3, NULL, NULL), (3, 5, 5, NULL, 1), (4, 8, 0, 'default1', 0), (5, NULL, 9, 'default2', NULL), (6, 1, 2, 'default2', 0), (7, 6, -1, 'RED', 0), (8, 9, 11, NULL, 0), (9, 7, -1, 'default2', 1), (10, 6, -1, 'default1', NULL), (11, 7, 11, 'default2', NULL), (12, 8, -1, 'default2', 1), (13, 6, 3, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
('RED',)
('RED',)
('default1',)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT S1.NAME FROM SALESPERSON AS S1 WHERE NOT S1.NAME IN (SELECT DISTINCT S.NAME FROM SALESPERSON AS S INNER JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID INNER JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/