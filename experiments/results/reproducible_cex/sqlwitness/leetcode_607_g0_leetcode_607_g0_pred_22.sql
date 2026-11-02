-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, 'default1'), (-1, 'RED', NULL), (0, 'RED', 'default1'), (2, NULL, 'default1'), (3, 'default2', 'RED'), (4, 'RED', NULL), (5, 'default2', 'RED'), (6, 'default2', 'default1'), (7, 'RED', NULL), (8, 'default2', 'RED'), (9, 'RED', 'default1'), (10, NULL, NULL), (11, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', 0, NULL, 'default1'), (0, 'default2', 0, 1, 'default2'), (1, 'RED', 0, NULL, NULL), (2, 'default1', NULL, 1, 'default1'), (3, NULL, NULL, NULL, 'default2'), (4, 'RED', 0, 1, NULL), (5, NULL, 0, 0, 'default2'), (6, 'RED', 0, 1, 'default2'), (7, 'default1', 1, 0, NULL), (8, 'default1', NULL, NULL, 'default1'), (9, 'default2', NULL, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 0, 'default2', 1), (0, 9, NULL, 'RED', 1), (-1, 5, -1, 'default2', 0), (2, 5, 4, NULL, NULL), (3, 2, 3, NULL, 0), (4, 1, 8, NULL, 1), (5, 4, 1, 'default2', 0), (6, NULL, 7, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default2',)
('default1',)
(None,)
('RED',)
(None,)
('RED',)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT S.NAME FROM SALESPERSON AS S CROSS JOIN COMPANY AS C JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID AND C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
('default2',)
('default2',)
('default1',)
('default1',)
('default1',)
('default2',)
*/