-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'default2'), (0, 'RED', 'RED'), (-1, 'RED', NULL), (2, 'RED', 'RED'), (3, 'RED', NULL), (4, NULL, NULL), (5, NULL, NULL), (6, 'RED', 'default2'), (7, 'default1', 'default2'), (8, 'default2', NULL), (9, 'default1', 'default2'), (10, 'RED', 'default1'), (11, NULL, NULL), (12, 'default1', 'default1'), (13, 'default2', 'default2'), (14, 'RED', 'default2'), (15, NULL, 'default1'), (16, 'default1', 'default1'), (17, 'default2', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', 1, NULL, 'default1'), (0, 'RED', 0, NULL, 'RED'), (1, 'default1', 1, 0, NULL), (2, 'default2', NULL, NULL, 'default2'), (3, 'default1', 1, 0, 'default1'), (4, 'RED', 1, 1, NULL), (5, NULL, NULL, 1, 'default1'), (6, NULL, 0, NULL, NULL), (7, 'RED', 0, 1, 'default2'), (8, 'RED', 1, 1, 'default2'), (9, NULL, 1, 0, 'RED'), (10, 'RED', NULL, 0, 'default2'), (11, 'RED', 0, 1, 'default2'), (12, 'RED', NULL, 0, 'default2'), (13, 'default1', 1, NULL, 'RED'), (14, NULL, 0, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 8, 3, 'RED', 1), (-1, 13, 4, 'RED', NULL), (1, 14, 1, NULL, 0), (2, 14, 0, 'RED', 0), (3, 5, 10, NULL, 0), (4, 3, 12, NULL, NULL), (5, 12, 3, 'default1', 1), (6, 5, 1, 'default2', 1), (7, 2, NULL, 'default1', 1), (8, 9, 12, 'default1', 1), (9, 13, 14, 'RED', 1), (10, 9, 10, NULL, 0), (11, 17, 1, 'default2', NULL), (12, 7, 6, 'default1', 1), (13, 14, 2, NULL, 1), (14, 5, 13, 'RED', 1), (15, 4, NULL, NULL, 1), (16, 9, 0, 'RED', NULL), (17, 5, NULL, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('RED',)
(None,)
(None,)
('RED',)
('RED',)
(None,)
('RED',)
('RED',)
('default1',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS AS T2 JOIN COMPANY AS T3 ON T2.COM_ID = T3.COM_ID WHERE T3.NAME = 'RED');

/*
Prediction Result:
*/