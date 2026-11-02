-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'default2'), (-1, 'default2', 'default2'), (0, 'default2', 'RED'), (2, 'RED', 'default2'), (3, 'default2', NULL), (4, 'default2', 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 1, 0, 'default2'), (0, 'RED', NULL, NULL, 'default2'), (1, 'default1', 1, 0, 'RED'), (2, 'RED', NULL, NULL, 'default1'), (3, 'RED', 0, 1, 'default1'), (4, 'default2', NULL, 1, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 0, 4, 'default2', NULL), (-1, 3, 4, 'default2', NULL), (0, 2, 0, 'default2', NULL), (2, 2, 4, 'default2', 0), (3, NULL, 1, 'default1', 0), (4, 4, 2, 'RED', NULL), (5, 1, 0, NULL, 0), (6, 0, 0, NULL, 1), (7, 1, NULL, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default1',)
('RED',)
('RED',)
*/

-- Prediction Query
SELECT S.NAME FROM SALESPERSON AS S WHERE NOT S.NAME IN (SELECT S2.NAME FROM SALESPERSON AS S2 JOIN ORDERS USING (SALES_ID) JOIN COMPANY AS C USING (COM_ID) WHERE C.NAME = 'RED');

/*
Prediction Result:
('default1',)
*/