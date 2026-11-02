-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', NULL), (-1, NULL, 'default2'), (1, 'default2', 'RED'), (2, 'default1', 'default1'), (3, 'RED', 'default2'), (4, 'default2', 'default2'), (5, 'RED', 'RED'), (6, 'default2', 'default2'), (7, NULL, NULL), (8, 'default2', 'default1'), (9, NULL, 'default2');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 1, 0, 'RED'), (0, NULL, 0, NULL, 'RED'), (-1, 'default2', 0, 1, 'default1'), (2, 'default2', 1, 0, 'RED'), (3, 'RED', NULL, 0, 'default2'), (4, 'default1', 1, 0, 'default2'), (5, 'default2', 0, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 3, 1, 'default2', NULL), (-1, 2, 3, 'default1', 0), (1, 9, 2, NULL, 1), (2, 3, 2, NULL, 1), (3, 5, 1, NULL, NULL), (4, 7, -1, 'RED', NULL), (5, 2, 0, 'default2', 1), (6, 7, 0, 'default2', 0), (7, -1, 1, 'default1', 0), (8, 9, 2, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
(None,)
('RED',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT C.NAME FROM ORDERS AS A LEFT JOIN COMPANY AS B ON A.COM_ID = B.COM_ID LEFT JOIN SALESPERSON AS C ON A.SALES_ID = C.SALES_ID WHERE B.NAME = 'RED');

/*
Prediction Result:
*/