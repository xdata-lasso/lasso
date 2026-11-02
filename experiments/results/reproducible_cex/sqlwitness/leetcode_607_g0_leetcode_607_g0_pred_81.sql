-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, NULL, 'RED'), (1, NULL, 'default2'), (0, NULL, 'default2'), (2, 'default1', 'default1'), (3, 'RED', 'default1'), (4, 'RED', 'default1'), (5, 'default2', 'default1'), (6, NULL, 'default1'), (7, 'RED', 'RED'), (8, 'RED', 'default2'), (9, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default2', NULL, NULL, 'RED'), (1, 'default2', NULL, 1, 'default2'), (0, NULL, 0, 1, NULL), (2, 'RED', 0, NULL, NULL), (3, NULL, 1, 1, 'default1'), (4, NULL, NULL, NULL, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 8, NULL, 'default1', NULL), (1, 0, 3, 'default2', 0), (-1, NULL, 0, 'default1', 1), (2, 0, 0, 'default1', 1), (3, 7, 4, 'default1', 1), (4, 7, 4, 'RED', 0), (5, 5, NULL, NULL, 1), (6, -1, 4, NULL, 0), (7, 5, 4, NULL, NULL), (8, -1, -1, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
(None,)
('default2',)
('RED',)
(None,)
*/

-- Prediction Query
WITH TEMP AS (SELECT A.*, B.NAME FROM ORDERS AS A LEFT JOIN COMPANY AS B ON A.COM_ID = B.COM_ID WHERE B.NAME IN ('RED')) SELECT A.NAME FROM SALESPERSON AS A WHERE NOT A.SALES_ID IN (SELECT SALES_ID FROM TEMP);

/*
Prediction Result:
*/