-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, NULL, 'default1'), (1, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 0, NULL, 'RED'), (0, 'default2', 1, NULL, 'default2'), (1, NULL, 0, 0, NULL), (2, 'RED', 1, 0, 'default2'), (3, 'default1', 1, 0, NULL), (4, NULL, 0, 1, NULL), (5, 'default2', 1, 1, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 1, 1, NULL, 1), (0, 1, NULL, 'default2', 0), (-1, NULL, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default2',)
('RED',)
('default1',)
(None,)
('default2',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.SALES_ID IN (SELECT ORDERS.SALES_ID FROM ORDERS JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
*/