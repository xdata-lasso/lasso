-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default1', 'default2'), (-1, 'default2', 'default1'), (0, 'default1', 'default2'), (2, 'default1', NULL), (3, NULL, 'default1'), (4, 'RED', 'RED'), (5, NULL, 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 1, 0, NULL), (0, NULL, NULL, NULL, 'RED'), (-1, 'RED', NULL, 0, 'default1'), (2, 'default1', 1, 1, 'default2'), (3, 'RED', 1, 0, 'default2'), (4, 'default1', NULL, 1, 'RED'), (5, 'RED', NULL, 1, NULL), (6, NULL, NULL, 1, 'default1'), (7, 'RED', 0, 0, 'default1'), (8, 'default1', NULL, NULL, 'default2'), (9, 'default1', 1, 1, 'default1'), (10, 'default2', NULL, 0, 'default1'), (11, 'default2', NULL, NULL, 'default2'), (12, 'RED', 0, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, NULL, 9, 'RED', NULL), (-1, 4, 1, 'default1', 1), (0, NULL, 7, 'default1', 0), (2, 5, NULL, 'default2', 0), (3, 1, 9, 'default1', 1), (4, -1, 8, 'default1', NULL), (5, NULL, 0, 'RED', NULL), (6, 0, 11, 'RED', 0), (7, 5, -1, 'default2', 0), (8, 2, 9, 'default1', 0), (9, 4, 11, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
('default1',)
('RED',)
('default1',)
('RED',)
(None,)
('RED',)
('default1',)
('default1',)
('default2',)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT DISTINCT S.NAME FROM SALESPERSON AS S JOIN ORDERS AS O ON S.SALES_ID = O.SALES_ID JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
('RED',)
('default1',)
('RED',)
('default1',)
('RED',)
('RED',)
('default1',)
('default1',)
('RED',)
*/