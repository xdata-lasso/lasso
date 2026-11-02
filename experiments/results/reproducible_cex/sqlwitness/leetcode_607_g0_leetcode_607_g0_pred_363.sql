-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'default1'), (0, 'default2', NULL), (1, 'RED', NULL), (2, NULL, NULL), (3, NULL, 'RED'), (4, NULL, NULL), (5, 'RED', 'default2'), (6, NULL, 'default2'), (7, NULL, NULL), (8, 'RED', 'RED'), (9, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', NULL, NULL, 'default2'), (0, 'RED', NULL, 0, 'default1'), (-1, NULL, 1, 0, 'default1'), (2, 'default2', NULL, NULL, 'default2'), (3, 'default2', 1, 0, 'RED'), (4, NULL, 1, NULL, NULL), (5, 'RED', NULL, NULL, NULL), (6, 'RED', 1, 0, 'default2'), (7, NULL, 0, 1, 'default2'), (8, 'default1', NULL, 1, NULL), (9, NULL, 0, NULL, NULL), (10, 'default1', 1, 0, 'default1'), (11, 'RED', 0, NULL, NULL), (12, 'default1', NULL, 0, 'default1'), (13, 'RED', 0, 0, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 5, 13, 'RED', 0), (1, 1, 6, 'default2', 0), (-1, 9, 1, 'default1', 0), (2, 7, NULL, 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('default2',)
('default2',)
(None,)
('RED',)
(None,)
('default1',)
(None,)
('default1',)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
(None,)
('RED',)
('RED',)
('default2',)
('default2',)
(None,)
('RED',)
(None,)
('default1',)
(None,)
('default1',)
('RED',)
('default1',)
('RED',)
*/