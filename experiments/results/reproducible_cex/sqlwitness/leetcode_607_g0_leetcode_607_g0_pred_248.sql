-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'default1'), (1, 'RED', NULL), (0, 'RED', 'RED'), (2, NULL, NULL), (3, 'RED', NULL), (4, NULL, 'default1'), (5, 'RED', 'RED'), (6, 'default1', 'default2'), (7, 'default1', NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'default2', 1, 0, 'default1'), (-1, 'default1', 1, 0, 'default2'), (0, 'RED', 1, 0, NULL), (2, 'RED', 1, 0, NULL), (3, 'default2', 0, 0, NULL), (4, 'RED', NULL, NULL, 'default2'), (5, NULL, 1, 0, 'default2'), (6, 'default2', NULL, 0, NULL), (7, 'RED', 1, NULL, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, 7, 7, 'RED', NULL), (1, 1, 3, 'default1', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default1',)
('RED',)
('default2',)
('RED',)
('RED',)
(None,)
('default2',)
('RED',)
*/

-- Prediction Query
WITH RED_ORDERS AS (SELECT SALESPERSON.NAME FROM ORDERS LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID LEFT JOIN SALESPERSON ON ORDERS.SALES_ID = SALESPERSON.SALES_ID WHERE COMPANY.NAME = 'RED') SELECT SALESPERSON.NAME FROM SALESPERSON LEFT JOIN RED_ORDERS ON RED_ORDERS.NAME = SALESPERSON.NAME WHERE RED_ORDERS.NAME IS NULL;

/*
Prediction Result:
('default1',)
('RED',)
('RED',)
('RED',)
(None,)
('RED',)
*/