-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, NULL, 2, 0, 'default2'), (2, 'default2', 0, 2, NULL), (0, 'RED', 1, 1, 'default2'), (1, 'default2', NULL, 2, NULL);
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (-1, NULL, NULL, 'default1', 0), (1, NULL, -1, 'default1', 0), (2, NULL, 2, 'default1', 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
(None,)
('RED',)
('default2',)
('default2',)
*/

-- Prediction Query
WITH SOLD_TO_RED AS (SELECT DISTINCT O.SALES_ID FROM ORDERS AS O INNER JOIN COMPANY AS C ON O.COM_ID = C.COM_ID AND C.NAME = 'RED') SELECT DISTINCT SP.NAME FROM SALESPERSON AS SP WHERE NOT EXISTS(SELECT 1 FROM SOLD_TO_RED WHERE SP.SALES_ID = SOLD_TO_RED.SALES_ID);

/*
Prediction Result:
(None,)
('RED',)
('default2',)
*/