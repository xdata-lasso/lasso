-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'default2'), (-1, 'default2', 'default1'), (1, NULL, 'default1'), (2, 'RED', 'RED'), (3, 'default2', 'default2'), (4, 'RED', 'default2'), (5, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 0, 1, NULL), (0, 'default1', 1, 1, 'RED'), (1, 'RED', 0, NULL, 'default2'), (2, 'default2', 1, NULL, 'RED'), (3, 'default2', NULL, 0, 'RED'), (4, 'default1', 0, 0, 'default1'), (5, 'RED', NULL, 0, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 5, NULL, 'default1', 1), (0, NULL, 3, 'RED', NULL), (-1, 1, 4, 'default2', 1), (2, 0, 1, 'default1', NULL), (3, NULL, 0, 'default2', 1), (4, 1, 2, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default1',)
('default2',)
('default2',)
('default1',)
('RED',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT NAME FROM SALESPERSON INNER JOIN ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID WHERE ORDERS.COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED'));

/*
Prediction Result:
('default1',)
('default2',)
('default2',)
('default1',)
*/