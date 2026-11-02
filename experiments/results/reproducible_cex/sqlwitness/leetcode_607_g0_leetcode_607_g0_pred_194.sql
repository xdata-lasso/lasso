-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, NULL, NULL), (-1, 'default2', 'RED'), (1, NULL, 'RED'), (2, 'RED', 'default1'), (3, 'default2', 'default1'), (4, NULL, 'default1'), (5, NULL, 'RED'), (6, 'RED', NULL), (7, 'default1', NULL), (8, NULL, 'default2'), (9, NULL, NULL), (10, 'RED', 'default1'), (11, 'RED', 'default2'), (12, NULL, NULL), (13, 'RED', 'default2'), (14, 'default1', 'default1'), (15, 'RED', 'RED'), (16, NULL, 'default2'), (17, 'default2', 'RED'), (18, 'default2', 'default2'), (19, 'default1', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', 0, NULL, 'default1'), (0, 'default2', 0, NULL, 'RED'), (1, 'RED', NULL, NULL, 'default1'), (2, 'default2', NULL, NULL, 'default2'), (3, 'default2', 1, 1, 'default1'), (4, 'default1', 1, NULL, 'default1'), (5, 'default2', 0, NULL, NULL), (6, 'default2', 1, 0, 'RED'), (7, 'RED', 0, NULL, 'RED'), (8, 'RED', 1, NULL, 'default1'), (9, 'default2', 0, NULL, 'default2'), (10, NULL, 1, NULL, 'RED'), (11, 'default2', NULL, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 14, 8, 'RED', 1), (-1, 15, -1, 'default2', NULL), (0, 1, -1, 'default1', 0), (2, 2, NULL, 'default2', NULL), (3, 7, 8, NULL, 1), (4, 10, 0, 'default1', NULL), (5, NULL, 2, NULL, 0), (6, 15, 4, 'RED', NULL), (7, 19, 7, NULL, NULL), (8, 17, 0, 'default1', 0), (9, 5, 6, 'default1', 1), (10, 5, 8, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default2',)
('default2',)
('default2',)
('default2',)
('RED',)
('RED',)
('default2',)
(None,)
('default2',)
*/

-- Prediction Query
SELECT A.NAME FROM SALESPERSON AS A WHERE NOT A.SALES_ID IN (SELECT O.SALES_ID FROM COMPANY AS C JOIN ORDERS AS O ON C.COM_ID = O.COM_ID WHERE C.NAME = 'RED');

/*
Prediction Result:
*/