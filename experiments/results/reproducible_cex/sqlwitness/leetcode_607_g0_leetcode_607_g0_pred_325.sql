-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'default1'), (1, 'RED', 'default2'), (0, 'default2', 'default1'), (2, 'RED', NULL), (3, 'default1', 'RED'), (4, 'default1', 'default1'), (5, NULL, NULL), (6, 'default1', 'default1'), (7, NULL, NULL), (8, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 1, 1, NULL), (1, 'default2', 1, NULL, 'default2'), (-1, 'default2', 1, NULL, 'default2'), (2, 'RED', NULL, 1, 'RED'), (3, NULL, 1, 0, 'RED'), (4, 'default1', 0, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, -1, 1, 'default2', NULL), (0, 2, NULL, NULL, NULL), (-1, 0, -1, 'RED', NULL), (2, 8, 1, 'default1', 1), (3, 4, 4, NULL, 1), (4, 2, 3, 'default1', 1), (5, 2, -1, NULL, NULL), (6, 0, 2, 'default1', 0), (7, 5, 2, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default2',)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT SALESPERSON.NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT T2.SALES_ID FROM ORDERS AS T2 WHERE T2.COM_ID = (SELECT T1.COM_ID FROM COMPANY AS T1 WHERE T1.NAME = 'RED'));

/*
Prediction Result:
('default2',)
('default1',)
('default2',)
('RED',)
(None,)
('default1',)
*/