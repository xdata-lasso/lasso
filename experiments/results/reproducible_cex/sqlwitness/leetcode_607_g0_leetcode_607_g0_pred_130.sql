-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default1', 'default1'), (1, NULL, 'RED'), (-1, 'RED', 'default1'), (2, 'default2', NULL), (3, 'RED', 'default1'), (4, 'default2', NULL), (5, NULL, NULL), (6, NULL, 'default2'), (7, NULL, 'default2'), (8, 'default2', 'RED'), (9, 'RED', NULL), (10, 'default2', 'default1'), (11, NULL, NULL), (12, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 0, 0, 'default2'), (-1, 'RED', 0, 0, 'default1'), (1, 'default2', 0, 0, 'RED'), (2, NULL, 0, 1, NULL), (3, 'default2', 0, NULL, 'RED'), (4, NULL, 1, 1, 'RED'), (5, 'RED', NULL, NULL, NULL), (6, NULL, 1, NULL, 'default1'), (7, 'default1', NULL, 1, 'RED'), (8, 'default1', 0, 0, 'RED'), (9, 'RED', 1, 0, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, -1, 7, NULL, 0), (1, -1, NULL, 'default1', NULL), (-1, 4, 7, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default1',)
('default2',)
(None,)
('default2',)
(None,)
('RED',)
(None,)
('default1',)
('RED',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O INNER JOIN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED') AS RED_C ON RED_C.COM_ID = O.COM_ID);

/*
Prediction Result:
*/