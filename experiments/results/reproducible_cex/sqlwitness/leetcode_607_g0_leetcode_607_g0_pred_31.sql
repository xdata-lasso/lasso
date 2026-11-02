-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, NULL, 'RED'), (0, 'default2', 'RED'), (-1, 'RED', NULL), (2, 'RED', 'RED'), (3, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', NULL, 0, 'RED'), (0, 'RED', 1, 0, 'default1'), (-1, NULL, 1, 0, 'default1'), (2, NULL, NULL, 0, 'RED'), (3, 'default2', 0, 1, 'RED'), (4, 'default1', NULL, NULL, 'default1'), (5, 'RED', 0, 1, 'default2'), (6, 'default2', NULL, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 0, 5, 'default2', 1), (1, 1, NULL, 'RED', 1), (-1, 1, 3, NULL, NULL), (2, 1, 5, 'default2', 0), (3, 1, 1, 'default1', 1), (4, 2, 3, 'default1', 0), (5, 2, -1, 'default2', 0), (6, 2, 0, 'default2', NULL), (7, 0, 5, 'default1', NULL), (8, NULL, 2, NULL, 0), (9, 3, -1, 'default1', 0), (10, 0, 6, NULL, NULL), (11, 1, 0, 'default2', 0);
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
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT DISTINCT SALES_ID FROM ORDERS WHERE COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
(None,)
('RED',)
('RED',)
(None,)
('default2',)
('default1',)
('RED',)
('default2',)
*/