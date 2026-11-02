-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'default2'), (1, 'default2', 'RED'), (0, 'RED', NULL), (2, 'RED', 'default2'), (3, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', NULL, 1, 'RED'), (0, 'RED', 0, 0, 'RED'), (1, 'RED', 1, NULL, 'RED'), (2, NULL, NULL, NULL, 'RED'), (3, 'default1', NULL, 0, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 2, NULL, 'RED', 1), (1, 2, NULL, NULL, 0), (-1, 3, NULL, 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('RED',)
('RED',)
(None,)
('default1',)
*/

-- Prediction Query
SELECT TB4.NAME FROM SALESPERSON AS TB4 WHERE NOT TB4.SALES_ID IN (SELECT TB1.SALES_ID FROM ORDERS AS TB1 LEFT JOIN COMPANY AS TB2 ON TB1.COM_ID = TB2.COM_ID WHERE TB2.NAME = 'RED');

/*
Prediction Result:
*/