-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'RED'), (-1, 'default1', 'default2'), (1, 'RED', 'RED'), (2, NULL, 'RED'), (3, NULL, NULL), (4, 'default2', NULL), (5, 'default1', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', NULL, NULL, 'RED'), (-1, 'default1', 0, NULL, 'default1'), (1, NULL, NULL, 0, 'default2'), (2, 'RED', 1, 0, 'default1'), (3, 'RED', NULL, NULL, 'default1'), (4, 'default2', 1, 1, 'RED'), (5, 'default1', 0, 0, 'default1'), (6, 'default2', 0, 0, NULL), (7, 'RED', 1, 0, NULL), (8, 'default1', NULL, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 4, 8, 'default2', 1), (1, 2, 5, 'RED', NULL), (-1, 0, 6, 'default1', 0), (2, 5, 2, 'default1', 1), (3, NULL, 7, NULL, 0), (4, 1, NULL, 'RED', NULL), (5, -1, 2, 'RED', NULL), (6, -1, 3, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('default1',)
(None,)
('RED',)
('RED',)
('default2',)
('default1',)
('RED',)
('default1',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS JOIN COMPANY AS C ON C.COM_ID = ORDERS.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/