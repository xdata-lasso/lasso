-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'default1'), (-1, 'default1', 'RED'), (1, 'RED', NULL), (2, 'default2', 'RED'), (3, 'RED', 'default1'), (4, 'RED', 'default2'), (5, NULL, 'default2'), (6, 'default1', 'default1'), (7, 'default1', 'default1'), (8, 'default2', 'RED'), (9, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 0, 0, 'default1'), (1, 'default1', NULL, NULL, 'RED'), (-1, 'default2', NULL, 1, 'default1'), (2, 'default1', 0, 0, 'default2'), (3, 'default2', 1, NULL, 'default2'), (4, 'default2', 1, 0, 'default1'), (5, NULL, 0, NULL, NULL), (6, 'default2', 1, 1, 'default2'), (7, 'default2', 1, 0, 'default2'), (8, 'RED', 0, 0, 'default1'), (9, 'default1', 1, 0, 'default2'), (10, 'default2', NULL, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 7, 4, 'default2', 1), (0, 5, 3, 'default2', NULL), (1, 3, 0, 'RED', 0), (2, NULL, 7, 'RED', 1), (3, NULL, NULL, 'RED', NULL), (4, 5, 3, 'RED', NULL), (5, 1, 6, 'default1', 0), (6, 4, 2, 'default1', NULL), (7, 0, 8, 'default1', NULL), (8, 7, 10, 'default2', 1), (9, 9, 9, 'RED', 1), (10, 2, NULL, NULL, NULL), (11, 4, 6, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('default2',)
('default2',)
(None,)
('default2',)
('RED',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT T1.SALES_ID FROM ORDERS AS T1 CROSS JOIN ORDERS AS T2 WHERE T1.SALES_ID = T2.SALES_ID AND T2.COM_ID = (SELECT COM_ID FROM COMPANY WHERE COMPANY.NAME = 'RED'));

/*
Prediction Result:
('default2',)
('RED',)
('default1',)
('default1',)
('default2',)
('default2',)
(None,)
('default2',)
('RED',)
('default1',)
('default2',)
*/