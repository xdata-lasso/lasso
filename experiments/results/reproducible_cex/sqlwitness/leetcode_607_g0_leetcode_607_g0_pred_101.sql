-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 1, 1, 'RED'), (-1, 'default2', 0, 0, 'default1'), (1, 'default2', 0, 1, 'default1'), (2, NULL, NULL, NULL, 'RED'), (3, 'RED', 1, 0, 'default1'), (4, 'RED', 0, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, NULL, -1, NULL, 0), (0, NULL, 0, 'RED', 0), (1, NULL, 1, 'default2', NULL), (2, NULL, NULL, NULL, 1), (3, NULL, 1, 'default1', 0), (4, NULL, -1, 'default1', NULL), (5, NULL, 4, 'default2', 0), (6, NULL, 3, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('default2',)
(None,)
('RED',)
('RED',)
*/

-- Prediction Query
SELECT DISTINCT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT O.SALES_ID FROM ORDERS AS O LEFT JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
('default2',)
('default1',)
(None,)
('RED',)
*/