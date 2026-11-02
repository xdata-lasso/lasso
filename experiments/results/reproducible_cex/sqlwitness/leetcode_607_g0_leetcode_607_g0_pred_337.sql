-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'default2', 'default1'), (-1, NULL, NULL), (0, NULL, 'default1'), (2, 'default1', 'default2'), (3, NULL, 'default2'), (4, NULL, NULL), (5, 'RED', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'default1', NULL, 1, 'RED'), (1, NULL, 0, 0, 'RED'), (0, 'default1', 0, 0, 'default2'), (2, 'RED', 0, 0, NULL), (3, 'default2', 1, NULL, 'default1'), (4, 'default1', NULL, 0, NULL), (5, 'default1', NULL, NULL, NULL), (6, 'default1', 0, 1, NULL), (7, 'RED', 1, NULL, 'RED'), (8, 'default1', 0, 1, NULL), (9, 'RED', NULL, 0, 'default2'), (10, NULL, 0, 1, 'RED'), (11, 'default1', 0, NULL, 'RED'), (12, 'default1', 1, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 3, 7, 'RED', 1), (0, 5, 9, 'RED', 0), (-1, -1, 10, 'default1', 1), (2, NULL, 9, 'RED', 0), (3, 5, -1, 'default2', 0), (4, NULL, 0, NULL, NULL), (5, 5, 6, NULL, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
(None,)
('RED',)
('default2',)
('default1',)
('default1',)
('RED',)
('default1',)
(None,)
('default1',)
('default1',)
*/

-- Prediction Query
SELECT SP.NAME FROM SALESPERSON AS SP WHERE NOT SP.NAME IN (SELECT SP.NAME FROM SALESPERSON AS SP CROSS JOIN COMPANY JOIN ORDERS ON (SP.SALES_ID = ORDERS.SALES_ID AND ORDERS.COM_ID = COMPANY.COM_ID) WHERE COMPANY.NAME = 'RED');

/*
Prediction Result:
('default2',)
*/