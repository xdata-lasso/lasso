-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, NULL, NULL), (1, 'default1', NULL), (-1, 'default1', 'default2'), (2, 'RED', NULL), (3, NULL, NULL), (4, 'RED', 'default2'), (5, NULL, 'default2'), (6, 'default2', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', 0, 1, 'RED'), (-1, NULL, 0, 0, 'RED'), (0, 'default2', 0, NULL, 'RED'), (2, 'RED', 0, 0, 'default2'), (3, 'default1', NULL, NULL, NULL), (4, 'RED', 1, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 3, 4, 'default2', NULL), (1, 6, 1, 'default1', 0), (-1, 4, NULL, NULL, 1), (2, 3, 3, 'RED', 0), (3, 6, 0, 'default2', 1), (4, 1, -1, 'default2', 1), (5, NULL, 2, 'default2', 0), (6, 0, 3, NULL, 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('default2',)
('RED',)
('RED',)
('default1',)
('RED',)
*/

-- Prediction Query
SELECT C.NAME FROM SALESPERSON AS C WHERE NOT C.SALES_ID IN (SELECT A.SALES_ID FROM ORDERS AS A LEFT JOIN COMPANY AS B ON A.COM_ID = B.COM_ID WHERE B.NAME = 'RED');

/*
Prediction Result:
*/