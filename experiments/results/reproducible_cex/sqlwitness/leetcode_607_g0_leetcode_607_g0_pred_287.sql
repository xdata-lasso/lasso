-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (1, 'RED', 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', 1, NULL, 'default2'), (1, 'RED', 0, 0, NULL), (-1, NULL, 0, 1, 'default2'), (2, 'default1', NULL, NULL, NULL), (3, 'RED', 0, NULL, 'RED'), (4, 'default1', NULL, 1, 'default1'), (5, NULL, NULL, 1, 'default2'), (6, 'RED', 1, 1, 'default1'), (7, NULL, NULL, 0, NULL), (8, 'default1', 0, 0, 'RED'), (9, 'default2', 0, NULL, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 1, -1, NULL, NULL), (-1, 1, 6, 'default2', 0), (1, NULL, 9, NULL, 1), (2, NULL, 5, 'RED', NULL), (3, NULL, NULL, 'default1', NULL), (4, 1, 3, NULL, NULL), (5, NULL, 6, 'RED', 0), (6, NULL, -1, NULL, 0), (7, NULL, 7, 'default2', NULL), (8, NULL, 6, NULL, NULL), (9, NULL, 5, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('RED',)
('default1',)
('default1',)
(None,)
(None,)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT DISTINCT SALESPERSON.NAME FROM SALESPERSON JOIN (SELECT ORDERS.* FROM ORDERS JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID WHERE COMPANY.NAME = 'RED') AS ORDERS ON SALESPERSON.SALES_ID = ORDERS.SALES_ID);

/*
Prediction Result:
*/