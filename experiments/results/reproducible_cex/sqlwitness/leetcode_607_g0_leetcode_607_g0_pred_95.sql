-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (0, 'default1', NULL, NULL, NULL), (2, 'RED', NULL, 2, 'default2'), (1, 'default2', 1, 1, NULL), (-1, 'default2', 0, 1, 'RED'), (3, 'default1', 0, 0, 'default2'), (4, 'default2', 1, 2, 'default2');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (2, NULL, -1, NULL, NULL), (1, NULL, 2, 'RED', 0), (0, NULL, 1, 'RED', NULL), (-1, NULL, 0, 'RED', 2), (3, NULL, 4, 'default2', 2), (4, NULL, 2, 'default2', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('default2',)
('default1',)
('default2',)
('RED',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT DISTINCT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM ORDERS WHERE COM_ID IN (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED' GROUP BY 1) GROUP BY 1);

/*
Prediction Result:
('default2',)
('default1',)
('RED',)
*/