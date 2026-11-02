-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'default1'), (1, NULL, 'default2'), (0, 'default2', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', NULL, 0, NULL), (0, 'RED', NULL, 0, NULL), (-1, NULL, NULL, NULL, 'RED'), (2, 'RED', 0, 0, NULL), (3, 'RED', 0, NULL, 'RED'), (4, 'default2', NULL, 0, 'RED'), (5, 'default2', 1, NULL, 'default2'), (6, 'default2', 1, 0, 'default2'), (7, 'RED', NULL, NULL, 'default1'), (8, 'default2', NULL, NULL, NULL), (9, 'RED', NULL, 0, 'default1'), (10, 'default2', 0, 0, NULL), (11, 'default1', 1, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, -1, 1, 'RED', 0), (0, -1, NULL, 'RED', 1), (1, NULL, 9, 'default2', 0), (2, 1, 5, 'default2', 1), (3, 0, 3, 'default1', 0), (4, 1, 2, NULL, 0), (5, 0, 5, 'default1', 1), (6, 1, 7, 'RED', 1), (7, 0, 0, NULL, NULL), (8, 1, 6, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('RED',)
('RED',)
('default2',)
('default2',)
('default2',)
('RED',)
('default2',)
('RED',)
('default2',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM COMPANY AS A CROSS JOIN ORDERS AS O WHERE A.COM_ID = O.COM_ID AND NAME = 'RED');

/*
Prediction Result:
*/