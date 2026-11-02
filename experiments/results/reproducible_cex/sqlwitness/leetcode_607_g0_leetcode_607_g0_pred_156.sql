-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default1', 'default1'), (0, 'default1', 'default1'), (1, NULL, 'RED'), (2, 'RED', 'default2'), (3, 'default2', 'default1'), (4, 'default2', 'RED'), (5, 'RED', 'default1'), (6, 'RED', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 0, 0, 'RED'), (-1, 'RED', 1, 1, 'default1'), (1, 'default1', 0, 0, 'default1'), (2, 'default1', 0, 1, 'default2'), (3, 'default1', 0, 1, 'RED'), (4, NULL, 0, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 6, 2, 'default1', 1), (0, -1, -1, NULL, NULL), (1, 0, NULL, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default1',)
('default1',)
('default1',)
(None,)
*/

-- Prediction Query
WITH CTE AS (SELECT SALES_ID FROM ORDERS WHERE COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED')) SELECT S.NAME FROM SALESPERSON AS S LEFT JOIN CTE ON S.SALES_ID = CTE.SALES_ID WHERE CTE.SALES_ID IS NULL;

/*
Prediction Result:
('RED',)
('default1',)
('default1',)
('default1',)
('default1',)
(None,)
*/