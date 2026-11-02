-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (-1, 'RED', 'default1'), (1, NULL, 'default1'), (0, NULL, 'default1');
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, 'RED', NULL, 0, 'default2'), (0, 'default2', NULL, 1, 'RED');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, -1, NULL, 'default2', 0), (-1, 0, 1, 'RED', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('RED',)
*/

-- Prediction Query
WITH CTE AS (SELECT SALES_ID FROM ORDERS WHERE ORDERS.COM_ID IN (SELECT COMPANY.COM_ID FROM COMPANY LEFT JOIN ORDERS ON COMPANY.COM_ID = ORDERS.COM_ID WHERE NAME = 'RED')) SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM CTE);

/*
Prediction Result:
*/