-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'RED'), (1, 'RED', 'default2'), (0, 'RED', NULL), (2, NULL, 'default2'), (3, NULL, 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'RED', 0, 0, 'RED'), (1, 'RED', 0, 1, 'RED'), (-1, NULL, NULL, 1, NULL), (2, 'RED', 0, NULL, NULL), (3, 'RED', NULL, NULL, 'default2'), (4, NULL, 1, NULL, 'default1'), (5, 'default1', 1, 1, 'default2'), (6, 'RED', 0, 1, NULL), (7, 'RED', 0, 0, 'default1'), (8, 'default2', 1, 0, 'default1'), (9, NULL, 0, 0, 'RED'), (10, NULL, NULL, NULL, 'default2'), (11, NULL, NULL, 1, 'default2'), (12, NULL, 1, 0, 'default2'), (13, NULL, 1, 0, 'default1'), (14, 'default1', NULL, 1, 'default1'), (15, 'default1', 0, 1, 'RED'), (16, 'RED', 0, 1, 'RED'), (17, NULL, 0, NULL, 'RED'), (18, 'default1', 1, 1, 'default2'), (19, NULL, NULL, NULL, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 3, 12, 'default2', 0), (-1, -1, 16, 'default2', NULL), (1, 3, 9, 'default1', 1), (2, 2, 11, 'default1', NULL), (3, NULL, -1, 'default1', 1), (4, 0, NULL, 'default2', 1), (5, NULL, 11, 'RED', NULL), (6, 2, 6, 'RED', NULL), (7, 2, 10, NULL, NULL), (8, 1, 11, 'default1', 1), (9, NULL, 2, 'default1', 0), (10, 1, 14, 'default2', NULL), (11, 0, 15, 'RED', 1), (12, 2, 8, 'RED', 1), (13, NULL, 3, 'RED', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('RED',)
('RED',)
('RED',)
(None,)
('default1',)
('RED',)
('RED',)
('default2',)
(None,)
(None,)
(None,)
(None,)
(None,)
('default1',)
(None,)
*/

-- Prediction Query
SELECT A.NAME FROM SALESPERSON AS A WHERE NOT A.SALES_ID IN (SELECT B.SALES_ID FROM ORDERS AS B LEFT JOIN COMPANY ON B.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
*/