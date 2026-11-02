-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', 'default1'), (1, 'default1', 'default2'), (-1, 'default1', 'default2'), (2, 'default1', 'default1'), (3, NULL, NULL), (4, 'RED', 'RED');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (-1, 'RED', 0, NULL, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (0, 2, NULL, 'RED', 1), (1, 2, NULL, 'default1', 0), (-1, NULL, -1, NULL, NULL), (2, NULL, NULL, NULL, 0), (3, 0, -1, NULL, NULL), (4, 4, NULL, 'default2', NULL), (5, 1, -1, 'default2', 1), (6, 1, NULL, NULL, 0), (7, 0, -1, 'default2', 0), (8, 1, -1, 'default2', 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
*/

-- Prediction Query
SELECT NAME FROM SALESPERSON WHERE NOT NAME IN (SELECT SALESPERSON.NAME FROM ORDERS LEFT JOIN COMPANY ON ORDERS.COM_ID = COMPANY.COM_ID LEFT JOIN SALESPERSON ON ORDERS.SALES_ID = SALESPERSON.SALES_ID WHERE COMPANY.NAME = 'RED' AND AMOUNT <> 0);

/*
Prediction Result:
('RED',)
*/