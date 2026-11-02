-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'default2', 'default1'), (-1, NULL, 'default1'), (1, NULL, 'RED'), (2, 'RED', NULL), (3, 'default1', 'RED'), (4, 'RED', 'RED'), (5, 'default1', 'default1'), (6, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 1, 0, 'default1'), (-1, 'RED', 0, 1, NULL), (0, 'default2', NULL, 0, NULL), (2, 'default1', 1, 1, 'default2'), (3, 'default1', 0, 0, 'default2'), (4, NULL, 0, 0, 'default1'), (5, 'default1', NULL, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 0, 1, NULL, NULL), (1, 3, 0, 'RED', 0), (-1, 4, 0, 'RED', NULL), (2, 5, 1, 'default2', NULL), (3, 1, NULL, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
(None,)
('default1',)
('default1',)
(None,)
('default1',)
*/

-- Prediction Query
SELECT DISTINCT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
('RED',)
(None,)
('default1',)
*/