-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'default2', NULL), (1, 'default1', 'RED'), (0, 'default1', 'RED'), (2, 'RED', 'default2'), (3, 'default2', NULL), (4, 'RED', 'default1'), (5, 'default1', 'default2'), (6, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', NULL, NULL, 'default2'), (1, 'default2', 1, 0, NULL), (0, NULL, 0, 1, 'RED'), (2, 'RED', 0, 1, NULL), (3, NULL, 0, NULL, 'RED'), (4, 'default1', NULL, NULL, 'default1'), (5, NULL, 0, NULL, 'RED'), (6, 'RED', 1, 1, 'default1'), (7, 'default2', 1, 0, NULL), (8, NULL, 0, NULL, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 5, 2, 'RED', 0), (0, 3, -1, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
(None,)
('default2',)
('RED',)
(None,)
('default1',)
(None,)
('RED',)
('default2',)
(None,)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT B.SALES_ID FROM COMPANY AS A INNER JOIN ORDERS AS B ON A.COM_ID = B.COM_ID WHERE A.NAME = 'RED') ORDER BY NAME, SALESPERSON.sales_id NULLS LAST;

/*
Prediction Result:
(None,)
(None,)
(None,)
(None,)
('RED',)
('RED',)
('default1',)
('default1',)
('default2',)
('default2',)
*/