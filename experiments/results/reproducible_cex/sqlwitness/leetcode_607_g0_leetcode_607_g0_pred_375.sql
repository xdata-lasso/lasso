-- Schema DDL
CREATE TABLE "salesperson" ("sales_id" INTEGER PRIMARY KEY, "name" TEXT(255), "salary" INTEGER, "commission_rate" INTEGER, "hire_date" TEXT(255), CHECK ("salary" >= 0), CHECK ("commission_rate" >= 0));

CREATE TABLE "company" ("com_id" INTEGER PRIMARY KEY, "name" TEXT(255), "city" TEXT(255));

CREATE TABLE "orders" ("order_id" INTEGER PRIMARY KEY, "com_id" INTEGER, "sales_id" INTEGER, "order_date" TEXT(255), "amount" INTEGER, FOREIGN KEY ("com_id") REFERENCES "company" ("com_id"), FOREIGN KEY ("sales_id") REFERENCES "salesperson" ("sales_id"), CHECK ("amount" >= 0));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO company (com_id, name, city) VALUES (0, 'RED', NULL), (1, 'RED', 'default1'), (-1, NULL, 'default1'), (2, NULL, 'RED'), (3, NULL, NULL);
INSERT INTO salesperson (sales_id, name, salary, commission_rate, hire_date) VALUES (1, NULL, 1, NULL, 'default1'), (-1, 'default1', 0, NULL, 'default1'), (0, 'RED', 0, NULL, 'RED'), (2, 'default2', 1, 0, 'RED'), (3, 'default2', 0, NULL, 'default1'), (4, 'RED', 1, 0, NULL), (5, 'default2', NULL, NULL, 'default2'), (6, 'default1', NULL, 1, 'default1');
INSERT INTO orders (order_id, com_id, sales_id, order_date, amount) VALUES (1, 0, 1, 'default1', 1), (0, 0, 4, NULL, 1), (-1, 1, -1, 'default1', NULL), (2, 2, 2, 'default1', NULL), (3, 1, 1, 'RED', 1), (4, 3, 6, 'default1', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT NAME FROM SALESPERSON AS S WHERE (SELECT COUNT(*) FROM ORDERS AS O JOIN COMPANY AS C ON O.COM_ID = C.COM_ID WHERE O.SALES_ID = S.SALES_ID AND C.NAME = 'RED') = 0;

/*
Gold Result:
('RED',)
('default2',)
('default2',)
('default2',)
('default1',)
*/

-- Prediction Query
WITH RED_SALES_PERSON_IDS AS (SELECT DISTINCT SALES_ID FROM ORDERS WHERE COM_ID = (SELECT COM_ID FROM COMPANY WHERE NAME = 'RED')) SELECT NAME FROM SALESPERSON WHERE NOT SALES_ID IN (SELECT SALES_ID FROM RED_SALES_PERSON_IDS);

/*
Prediction Result:
('default1',)
('RED',)
('default2',)
('default2',)
('default2',)
('default1',)
*/